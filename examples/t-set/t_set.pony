"""
Demonstrates TSet: a set with last-write-wins semantics using logical
timestamps. Concurrent operations are resolved by timestamp, with a
configurable bias for breaking ties.
"""
