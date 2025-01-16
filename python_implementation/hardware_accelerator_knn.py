import numpy as np
import time
import psutil

# Parameters
n = 26  # Number of samples
samples = np.array([0b00000, 0b00001, 0b00010, 0b00011, 0b00100, 0b00101, 0b00110, 0b00111,
                    0b01000, 0b01001, 0b01010, 0b01011, 0b01100, 0b01101, 0b01110, 0b01111,
                    0b10000, 0b10001, 0b10010, 0b10011, 0b10100, 0b10101, 0b10110, 0b10111,
                    0b11000, 0b11001])

samples1 = np.array([0b10100, 0b11001, 0b11001, 0b10000, 0b11111, 0b10100, 0b11001, 0b11111,
                     0b11110, 0b11100, 0b11010, 0b11011, 0b01001, 0b00011, 0b00111, 0b01111,
                     0b00100, 0b00111, 0b01000, 0b10011, 0b00101, 0b01000, 0b10110, 0b10111,
                     0b11000, 0b01001])

# Function to calculate distances and classify
def knn_classify(sample_in, sample_in1, k):
    # Calculate squared Euclidean distances
    distances = (sample_in - samples) ** 2 + (sample_in1 - samples1) ** 2

    # Get the indices of the k smallest distances
    nearest_indices = np.argpartition(distances, k)[:k]

    # Count class votes using logical indexing
    class_a = np.sum((nearest_indices <= 4) | ((nearest_indices > 8) & (nearest_indices <= 16)))
    class_b = k - class_a  # Remaining votes go to Class B

    # Return classification and LED states
    return ("Class A", 1, 0) if class_a > class_b else ("Class B", 0, 1)

# Inputs
k = 0b011  # k as 3 in binary
k1 = 0b101  # k1 as 5 in binary
samples_to_classify = [
    (0b00101, 0b01101),  # x=5, y=13
    (0b10011, 0b10001),  # x=19, y=17
    (0b01010, 0b10000),  # x=10, y=16
]

# Classification and timing
begin = time.time()
results = [knn_classify(x, y, k) for x, y in samples_to_classify]
results.append(knn_classify(samples_to_classify[2][0], samples_to_classify[2][1], k1))
end = time.time()

# Output results
for i, result in enumerate(results):
    print(f"Result {i + 1}: {result}")

print(f'The time taken is {end - begin:.6f} seconds')
print(f"CPU utilization: {psutil.cpu_percent()}%")
