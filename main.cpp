#include <immintrin.h>
#include <tuple>
#include <cstdint>

float fun1(float *a, float *b, unsigned char *x, float *d, uint64_t dim, uint64_t offset)
{
  offset /= 2;
  __m256 sum_vec = _mm256_setzero_ps();

  for (uint64_t i = 0; i < dim; i += 8)
  {
    uint32_t packed_bytes = *(uint32_t *)(x + i / 2 + offset);
    __m128i bytes_vec = _mm_set1_epi32(packed_bytes);
    __m128i low_mask = _mm_set1_epi32(0x0F0F0F0F);
    __m128i low_nibbles = _mm_and_si128(bytes_vec, low_mask);
    __m128i high_nibbles = _mm_and_si128(_mm_srli_epi32(bytes_vec, 4), low_mask);
    __m128i shuffle_mask = _mm_setr_epi8(
        0, 4, 8, 12,
        1, 5, 9, 13,
        2, 6, 10, 14,
        3, 7, 11, 15);
    __m128i low_shuffled = _mm_shuffle_epi8(low_nibbles, shuffle_mask);
    __m128i high_shuffled = _mm_shuffle_epi8(high_nibbles, shuffle_mask);
    __m128i interleaved_lo = _mm_unpacklo_epi8(high_shuffled, low_shuffled);
    __m128i interleaved_hi = _mm_unpackhi_epi8(high_shuffled, low_shuffled);
    __m128i values_32_lo = _mm_unpacklo_epi8(interleaved_lo, _mm_setzero_si128());
    __m128i values_32_hi = _mm_unpackhi_epi8(interleaved_lo, _mm_setzero_si128());
    values_32_lo = _mm_unpacklo_epi16(values_32_lo, _mm_setzero_si128());
    values_32_hi = _mm_unpacklo_epi16(values_32_hi, _mm_setzero_si128());
    __m256 x_vec = _mm256_cvtepi32_ps(_mm256_set_m128i(values_32_hi, values_32_lo));
    __m256 a_vec = _mm256_loadu_ps(&a[i]);
    __m256 b_vec = _mm256_loadu_ps(&b[i]);
    __m256 d_vec = _mm256_loadu_ps(&d[i]);
    __m256 result = _mm256_fmsub_ps(x_vec, a_vec, d_vec);
    result = _mm256_add_ps(result, b_vec);
    result = _mm256_mul_ps(result, result);
    sum_vec = _mm256_add_ps(sum_vec, result);
  }

  __m128 sum_high = _mm256_extractf128_ps(sum_vec, 1);
  __m128 sum_low = _mm256_castps256_ps128(sum_vec);
  __m128 sum_128 = _mm_add_ps(sum_high, sum_low);
  sum_128 = _mm_hadd_ps(sum_128, sum_128);
  sum_128 = _mm_hadd_ps(sum_128, sum_128);
  return _mm_cvtss_f32(sum_128);
}

struct ReconstructParameter
{
  __m128 lower_bound;
  __m128 step_size;
};

float fun2(const float *data, size_t offset, ReconstructParameter *bounds_data_,
           std::tuple<uint8_t, uint8_t, uint16_t> *combined_data_, size_t dim_)
{
  offset /= 4;
  __m256 sum8 = _mm256_setzero_ps();

  static const __m256i shifts = _mm256_setr_epi32(0, 2, 4, 6, 8, 10, 12, 14);
  static const __m256i mask = _mm256_set1_epi32(3);

  for (size_t i = 0; i < dim_; i += 8)
  {
    const size_t idx = i / 4;
    const auto [c1, c2, code] = combined_data_[(offset + idx) / 2];
    const auto [lb1, st1] = bounds_data_[idx * 256 + c1];
    const auto [lb2, st2] = bounds_data_[(idx + 1) * 256 + c2];
    const __m256 lb_vec = _mm256_insertf128_ps(_mm256_castps128_ps256(lb1), lb2, 1);
    const __m256 st_vec = _mm256_insertf128_ps(_mm256_castps128_ps256(st1), st2, 1);
    const __m256i bytes = _mm256_set1_epi32(code);
    const __m256i shifted = _mm256_srlv_epi32(bytes, shifts);
    const __m256i masked = _mm256_and_si256(shifted, mask);
    const __m256 code_vec = _mm256_cvtepi32_ps(masked);
    const __m256 reconstructed = _mm256_fmadd_ps(code_vec, st_vec, lb_vec);
    const __m256 data_vec = _mm256_loadu_ps(data + i);
    const __m256 diff = _mm256_sub_ps(reconstructed, data_vec);
    sum8 = _mm256_add_ps(sum8, _mm256_mul_ps(diff, diff));
  }

  __m128 sum4 = _mm_add_ps(_mm256_extractf128_ps(sum8, 1), _mm256_castps256_ps128(sum8));
  sum4 = _mm_hadd_ps(sum4, sum4);
  sum4 = _mm_hadd_ps(sum4, sum4);
  return _mm_cvtss_f32(sum4);
}