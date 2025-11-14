def sort_even_odd_desc(arr):
    genap = [x for x in arr if x % 2 == 0]
    ganjil = [x for x in arr if x % 2 != 0]
    
    # Urutkan masing-masing secara descending
    genap.sort(reverse=True)
    ganjil.sort(reverse=True)
    
    return genap + ganjil

input_array = [3, 2, 5, 1, 8, 9, 6]
output = sort_even_odd_desc(input_array)
print(f"Input:  {input_array}")
print(f"Output: {output}")
