import numpy as np


# CPUバウンドな重い処理を実行する関数
# 大きな乱数配列を生成してソートする
#
# 引数
# seed: 乱数のシード
# length: 配列の長さ
# n_iter: 処理の反復回数
def sort(seed, length=1_000_000, n_iter=100):
    rng = np.random.default_rng(seed)

    for _ in range(n_iter):
        random_array = rng.integers(0, high=length, size=length)
        random_array.sort()
        # print("Sorted a random array by seed: {}".format(seed))

    return True


# p.map()用のラッパー関数
def wrap_sort(args):
    return sort(*args)


def double(n):
    return 2 * n
