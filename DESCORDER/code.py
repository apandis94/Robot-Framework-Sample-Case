def sort_fungction(arr):
    ## Fungsi untuk mengurutkan angka genap terlebih dahulu dalam urutan menurun, diikuti oleh angka ganjil dalam urutan menurun
    angka_genap = [num for num in arr if num % 2 == 0]
    angka_ganjil = [num for num in arr if num % 2 != 0]
    
    angka_genap.sort(reverse=True)
    angka_ganjil.sort(reverse=True)
    
    return angka_genap + angka_ganjil

## input data
input_data = [3, 2, 5, 1, 8, 9, 6]
output = sort_fungction(input_data)
# Hasil'nya
print(f"Input: {input_data}")
print(f"Output: {output}")
