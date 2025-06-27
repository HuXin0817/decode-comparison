#include <immintrin.h>
#include <stdint.h>

void uq4decode(float *a, float *b, unsigned char *x, float *decode) {
  __m128i x_val = _mm_loadl_epi64((__m128i *)x);
  __m128i high_mask = _mm_set1_epi8(0xF0);
  __m128i low_mask = _mm_set1_epi8(0x0F);
  __m128i high_part = _mm_srli_epi16(_mm_and_si128(x_val, high_mask), 4);
  __m128i low_part = _mm_and_si128(x_val, low_mask);
  __m128i indices_8 = _mm_unpacklo_epi8(high_part, low_part);
  __m128i indices_lo = _mm_cvtepu8_epi32(indices_8);
  __m128i indices_hi = _mm_cvtepu8_epi32(_mm_srli_si128(indices_8, 4));
  __m256i indices = _mm256_set_m128i(indices_hi, indices_lo);
  __m256 indices_f = _mm256_cvtepi32_ps(indices);
  __m256 a_vec = _mm256_loadu_ps(a);
  __m256 b_vec = _mm256_loadu_ps(b);
  __m256 res = _mm256_fmadd_ps(indices_f, a_vec, b_vec);
  _mm256_storeu_ps(decode, res);
}

void uq8decode(float *a, float *b, unsigned char *x, float *decode) {
  __m128i x8 = _mm_loadl_epi64((__m128i *)x);
  __m256i x32 = _mm256_cvtepu8_epi32(x8);
  __m256 x_float = _mm256_cvtepi32_ps(x32);
  __m256 a_vec = _mm256_loadu_ps(a);
  __m256 b_vec = _mm256_loadu_ps(b);
  __m256 res = _mm256_fmadd_ps(x_float, a_vec, b_vec);
  _mm256_storeu_ps(decode, res);
}

void pouq4decode(float *a, float *b, unsigned char *x, float *decode) {
  uint32_t x_val = *((uint32_t *)x);
  __m128i x128 = _mm_cvtsi32_si128(x_val);
  __m128i x32 = _mm_cvtepu8_epi32(x128);
  __m128i cluster_high =
      _mm_and_si128(_mm_srli_epi32(x32, 6), _mm_set1_epi32(0x03));
  __m128i cluster_low =
      _mm_and_si128(_mm_srli_epi32(x32, 2), _mm_set1_epi32(0x03));
  __m128i cluster_hl0 = _mm_unpacklo_epi32(cluster_high, cluster_low);
  __m128i cluster_hl1 = _mm_unpackhi_epi32(cluster_high, cluster_low);
  __m256i cluster_index = _mm256_set_m128i(cluster_hl1, cluster_hl0);
  __m128i value_high =
      _mm_and_si128(_mm_srli_epi32(x32, 4), _mm_set1_epi32(0x03));
  __m128i value_low = _mm_and_si128(x32, _mm_set1_epi32(0x03));
  __m128i value_hl0 = _mm_unpacklo_epi32(value_high, value_low);
  __m128i value_hl1 = _mm_unpackhi_epi32(value_high, value_low);
  __m256i value_index = _mm256_set_m128i(value_hl1, value_hl0);
  __m256i base = _mm256_setr_epi32(0, 0, 4, 4, 8, 8, 12, 12);
  __m256i a_b_index = _mm256_add_epi32(base, cluster_index);
  __m256 a_gather = _mm256_i32gather_ps(a, a_b_index, 4);
  __m256 b_gather = _mm256_i32gather_ps(b, a_b_index, 4);
  __m256 value_f = _mm256_cvtepi32_ps(value_index);
  __m256 res = _mm256_fmadd_ps(value_f, b_gather, a_gather);
  _mm256_storeu_ps(decode, res);
}

void pouq8decode(float *a, float *b, unsigned char *x, float *decode) {
  __m128i x8 = _mm_loadl_epi64((__m128i *)x);
  __m256i x32 = _mm256_cvtepu8_epi32(x8);
  __m256i cluster_index = _mm256_srli_epi32(x32, 4);
  __m256i value_index = _mm256_and_si256(x32, _mm256_set1_epi32(0x0F));
  __m256i i_vec = _mm256_setr_epi32(0, 16, 32, 48, 64, 80, 96, 112);
  __m256i a_b_index = _mm256_add_epi32(i_vec, cluster_index);
  __m256 a_gather = _mm256_i32gather_ps(a, a_b_index, 4);
  __m256 b_gather = _mm256_i32gather_ps(b, a_b_index, 4);
  __m256 value_f = _mm256_cvtepi32_ps(value_index);
  __m256 res = _mm256_fmadd_ps(value_f, b_gather, a_gather);
  _mm256_storeu_ps(decode, res);
}
