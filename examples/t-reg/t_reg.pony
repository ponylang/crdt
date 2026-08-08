"""
Demonstrates TReg: a timestamp-based last-write-wins register. Concurrent
updates are resolved by logical timestamp. Ties are broken by a configurable
bias (BiasGreater by default).
"""
