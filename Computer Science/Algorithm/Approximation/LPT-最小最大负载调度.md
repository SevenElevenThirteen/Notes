# LPT：最小最大负载调度

## 问题定义

给定 $n$ 个不可拆分的物品，体积为 $w_1,\ldots,w_n$，以及 $m$ 个相同的背包。将每个物品分配给一个背包，使最大背包体积最小：

$$
\min_{\text{分配}}
\max_{1\le k\le m}\sum_{i\text{ 分配到背包 }k}w_i.
$$

这等价于**相同并行机上的最小最大负载调度问题**（identical parallel machine makespan scheduling，常记作 $P\|C_{\max}$）。最优最大负载记为 $\mathrm{OPT}$。

## LPT 贪心算法

1. 按物品体积从大到小排序；
2. 依次将每个物品放入当前总体积最小的背包。

该算法称为 **LPT**（Longest Processing Time first）。

## 近似比证明

### 一般的 2-近似界

设算法最终最满的背包中，最后放入的物品体积为 $w_j$，放入它之前该背包的体积为 $L$。当时该背包是最轻的，因此其负载不超过当时所有背包负载的平均值：

$$
L\le \frac{\sum_{i\text{ 已放入}}w_i}{m}
\le \frac{\sum_i w_i}{m}
\le \mathrm{OPT}.
$$

又因为任何物品都必须被放入某个背包，故 $w_j\le \mathrm{OPT}$。于是算法最大负载 $C_{\mathrm{LPT}}=L+w_j\le 2\mathrm{OPT}$。因此它是 2-近似算法。这个证明实际上对任意物品处理顺序都成立。

### LPT 的更强界

LPT 的经典紧近似比为

$$
\boxed{\frac{C_{\mathrm{LPT}}}{\mathrm{OPT}}\le \frac43-\frac{1}{3m}}.
$$

仍设 $j$ 是最终最满背包中最后放入的物品。放入 $j$ 时，该背包是最轻的；而所有物品总体积不超过 $m\mathrm{OPT}$。去掉 $j$ 后可得

$$
L\le \frac{m\mathrm{OPT}-w_j}{m}
=\mathrm{OPT}-\frac{w_j}{m},
$$

所以

$$
C_{\mathrm{LPT}}=L+w_j
\le \mathrm{OPT}+\left(1-\frac1m\right)w_j.
$$

LPT 分析中的关键引理是：**若 LPT 的结果不是最优解，则上述关键物品满足 $w_j\le \mathrm{OPT}/3$。** 这是经典的 LPT 交换引理：若关键物品大于 $\mathrm{OPT}/3$，由于物品按降序处理，排在它之前的物品也都大于 $\mathrm{OPT}/3$；最优方案的每个背包至多容纳其中两个。结合 LPT 对这些较大物品的分配顺序作交换比较，可知关键背包的负载不会超过最优值，因而算法已经最优。

因此，若算法非最优，代入 $w_j\le \mathrm{OPT}/3$：

$$
C_{\mathrm{LPT}}
\le \mathrm{OPT}+\left(1-\frac1m\right)\frac{\mathrm{OPT}}3
=\left(\frac43-\frac{1}{3m}\right)\mathrm{OPT}.
$$

若算法最优，则同一上界当然成立。该界是 LPT 的经典最坏情况紧界；当 $m$ 增大时，近似比趋近于 $4/3$。

## 紧例：$m=2$

物品体积为 $3,3,2,2,2$。LPT 的分配过程得到负载 $7$ 和 $5$，所以最大负载为 $7$；最优分配可得到 $6$ 和 $6$，故 $\mathrm{OPT}=6$。近似比为

$$
\frac76=\frac43-\frac{1}{3\cdot2},
$$

正好达到该界在 $m=2$ 时的取值。

## 小结

- 问题：相同并行机最小最大负载调度，$P\|C_{\max}$。
- 算法：按体积降序，放入当前负载最小的背包（LPT）。
- 简单分析：任意放置顺序都有 2-近似保证。
- LPT 的经典紧界：$\displaystyle 4/3-1/(3m)$。
