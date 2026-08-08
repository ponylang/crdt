"""
Demonstrates GCounter: a grow-only counter where each replica can only
increment. The global value is the sum across all replicas. Incrementing
beyond the maximum value of the integer type saturates at the maximum.
"""
