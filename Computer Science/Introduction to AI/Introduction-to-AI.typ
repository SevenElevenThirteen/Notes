/* 中文伪粗体 */
#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold

/* 画图 */
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

/* 字体大小 */
#let 一号 = 28pt
#let 小一号 = 24pt
#let 二号 = 21pt
#let 小二号 = 18pt
#let 三号 = 16pt
#let 小三号 = 15pt
#let 四号 = 14pt
#let 小四号 = 12pt
#let 五号 = 10.5pt
#let 小五号 = 9pt

/*
    字体设置
    Times New Roman 不支持中文
    NSimSun 新宋体
    默认小四号
*/
#set text(
    font: ("Times New Roman", "NSimSun"),
    size: 小四号
)

/*
    页面设置
    A4
    页边缘：上下 2.54cm；左右 1.91cm
*/
#set page(
    paper: "a4",
    margin: (x: 2.54cm, y: 2.1cm)
)

/*
    段落设置
    段前空两格
*/
// #set par(
//     hanging-indent: -2em
// )

/*
    宏
*/
#let vect(x) = math.bold(math.upright(x))

#page()[
    #align(center + horizon)[
        #text(size: 一号)[
            人工智能引论
        ]

        #v(10pt)

        #text(size: 小二号)[
            1001
        ]
    ]
]

#set heading(numbering: "I.a.")

#text(size: 二号)[
    #outline(
        title: "目录",
        depth: 2
    )
]

#pagebreak(weak: true)

= #text(size: 二号)[
    聚类分析
]

分类。

划分 / 层次 / 密度：簇之间无交 / 包含关系构成树 / 按密度划分簇 \
互斥 / 重叠 / 模糊：每个对象属于 1 / $gt.slant$ 1 / $epsilon in [0, 1]$ 个簇

层次的：凝聚的 / 分裂的：每次合并簇 / 拆分簇

== #text(size: 小三号)[
    K-means
]

划分的，分成 $k$ 个簇。
#rect()[
    + 初始化 $k$ 个质心
    + 对每个点，划分到最近的质心下
    + 更新质心
    + 迭代
]

误差平方和 $"SSE" := sum_(i = 1)^(k) sum_(x in S_i) "dist"^2(m_i, x)$
可以证明 SSE 单调不增，若划分变化则 SSE 严格下降，必然停机。但收敛速度不定。

影响因素：
- 规模：高时间复杂度。
- 密度：K-means 假设密度均匀，低密度点会误入高密度簇。最小化 SSE 倾向生成大小相似的簇。
- 形状：K-means 假设数据分布呈球形。对非球形分布不准。

选初始质心：
+ 先选一个：随机 / 全集质心
+ 对后继质心，（从数据点中）选离已选质心最远的。

问题：可能选离群点当质心，代表性下降。\
解决：提前删除离群点，后续是否加入？删除很小的簇。

== #text(size: 小三号)[
    DBSCAN
]
密度的

取半径 r，阈值 Bar。取邻域 $U$ 为半径为 r 的圆，对点分类：
- 核心点：$U$ 内有 $gt.slant$ Bar 个点
- 边缘点：$U$ 内有 $lt.slant$ Bar 个点，但其在核心点的邻域内
- 噪音点：都不是

直接密度可达：$v$ 在核心点 $u$ 的邻域内，连边 $u arrow.r v$\
因此，核心点之间构成双向边，只有末端一度点可能为边缘点。在核心点层面上，每次创建的簇两两无交。

#rect()[
    + 从未处理的点中任取一个核心点 $u$
    + 创建新簇，把 $u$ 与 $u arrow.r.squiggly v$ 的 $v$ 划入其中，并标记为处理过
    + 迭代至没有核心点
]

影响因素：
- $epsilon$ #[
    - 大：合并簇，区分度差
    - 小：大量噪音点
]
- Bar #[
    - 大：忽略低密度簇
    - 小：划噪音为簇
]

== #text(size: 小三号)[
    凝聚型层次聚类法
]

维护邻近度矩阵。

#rect()[
    + 初始化，每个点成为一个簇
    + 合并最近的两个簇，更新矩阵
    + 迭代
]

邻近度定义：
- Min / Max：取簇间点的距离 Min / Max，又叫单链 / 全链
- Average：所有点对距离平均值

问题：
- 局部最优，未必全局最优
- 高时空
- 大数据集分解差

#pagebreak(weak: true)

= #text(size: 二号)[
    分类
]

监督：对数据的标注

== #text(size: 小三号)[
    贝叶斯分类
]

记导致事件 $B$ 的所有原因为 ${A_n}$。实践上，容易得到原因触发结果的概率，即 $P(B | A_i)$。当结果 $B$ 发生时，由此反推 $A_i$ 成为原因的概率。

全概率
$ P(B) = sum P(B | A_i) P(A_i) $

贝叶斯
$ P(A_i | B) = P(A_i inter B)/P(B) = (P(A_i)P(B | A_i))/(sum P(B | A_i)P(A_i)) $

极大后验假设 Maxinum A Posteriori (MAP)：找主要原因
$ h &= arg max_i P(A_i | B)\
&= arg max_i (P(A_i)P(B | A_i))/(P(B))\
&= arg max_i P(A_i)P(B | A_i) $

朴素贝叶斯分类：
- 数据集 ${vect(x), y}$：$vect(x) = (a_1, dots.c, a_n)$ 为一列事件/属性，$y$ 为观测到的结果。
- 测试：现在发生了 $vect(x)'$，求最可能的结果 $y'$。（仿佛 $y$ 导致 $vect(x)$，找 $y$）
#align(center)[#rect()[
    $ y' &= arg max_y P(y | vect(x'))\
    &= arg max_y P(y)P(vect(x') | y)\
    &= arg max_y P(y) product P(a_i ' | y) quad "独立性假设" $
]]

从数据中估计 $P(y), P(a_i | y)$ 都容易，直接估计 $P(vect(x) | y)$ 面临数据不足的问题。

== #text(size: 小三号)[
    决策树
]

本质 K-D Tree。

#rect()[
    + 取一个性状，按相对性状对数据分类
    + 对每一类递归，递归关系构成决策树
]

优先取分类效果好的特征进行分类。

优劣评价标准：信息增益。熵减越多，分类效果越好。\
$P_i$ 是对最终结果的概率估计，这是唯一关心的性状，其它性状只是辅助用于分类。
- 熵 $H(S) = - sum P_i log P_i$
- 条件熵 $H(S | A) = sum (S_i)/(S) H(S_i)$
- 信息增益 $g(S, A) := H(S) - H(S | A)$

问题：过拟合。分类过细。

记 $"sz"(u)$ 为 $u$ 子树内的样本数，$N(T)$ 为决策树 $T$ 的叶子数量，取 $alpha$ 为一调节系数，定义损失函数
#align(center)[#rect()[$ C(T) = underbrace(sum_(u in "leaf") "sz"(u) H(u), "限制分类误差")  + underbrace(alpha N(T), "限制树大小") $]]
目标：减小 $C(T)$。

优化：
- 剪枝：#[
    - 调整：计算 $C(T)$ 增量
    - 设阈值：限制 Max-Dep / Min-Size
]
- 调参 $alpha$
- 决策树森林：组合多棵树
- 提前分类，对每一类构建决策树。

优点：不受特征尺度影响；支持多样数据类型；支持多变量预测\
缺点：过拟合；不稳定，结构受数据微扰影响大；倾向于选择具有更多类别的特征

== #text(size: 小三号)[
    支持向量机 SVM
]

Support Vector Machine. SVM

用超平面划分点集，本质二分类。

=== 线性 SVM

超平面 $vect(n) dot.c vect(x) + "b" = 0$，其中 $vect(w)$ 为法向量，$"b" in RR$ 为常数。

点到超平面距离 $ "Dist"(vect(x)) = abs((vect(x) - vect(x)_0) dot.c (vect(w))/(norm(vect(w)))) = (abs(sum a_i x_i + "b"))/(sqrt(sum a_i^2)) = (abs(vect(w) dot.c vect(x) + "b"))/(norm(vect(w))) $

给定点集，找一张超平面 $alpha$，最大化到平面最小距离 $max {min "Dist"(vect(x))}$。记这最小距离为 $d$，则 $"Dist" = d$ 的点称支持向量，其撑起了分界线。任一点代入 $alpha$ 方程，结果正负代表位于平面的上/下方，实现了二分类。
$ f(vect(x)) = "sgn"(vect(w) dot.c vect(x) + "b") $

训练集 $"T" = {(vect(x)_n, y_n)}, space y_i in {1, -1}$。$y_i$ 为标记（上方/下方），引入标记以免去 sgn 函数。\
函数间隔：$hat(gamma) := y_i (vect(w) dot.c vect(x)_i + "b")$ \
归一化 $gamma := hat(gamma)/norm(vect(w)) = y_i (vect(w)/norm(vect(w)) dot.c vect(x)_i + "b"/norm(vect(w)))$

目标：
$ & max_(vect(w), "b") gamma & quad s.t. & space y_i (vect(w)/norm(vect(w)) dot.c vect(x)_i + "b"/norm(vect(w))) gt.slant gamma \
arrow.l.r.double & max_(vect(w), "b") hat(gamma)/norm(vect(w)) & quad s.t. & space y_i (vect(w) dot.c vect(x)_i + "b") gt.slant hat(gamma) $

令 $hat(gamma) = 1$，即人为划定一个间隔带。归一化的 $gamma$ 即 Dist，但实际计算中 $hat(gamma)$ 更容易。$1/2$ 的系数使求导后常数归一。
$ arrow.l.r.double & max_(vect(w), "b") 1/norm(vect(w)) & quad s.t. space & y_i (vect(w) dot.c vect(x)_i + "b") gt.slant 1 \
arrow.l.r.double & min_(vect(w), "b") 1/2 norm(vect(w))^2 & quad s.t. space & y_i (vect(w) dot.c vect(x)_i + "b") gt.slant 1 $

希望将不等式转化为等式处理，引入松弛变量 ${xi_n}$，定义损失函数
#align(center)[#rect()[$ L = 1/2 norm(vect(w))^2 + C sum xi_i quad s.t. space y_i (vect(w) dot.c vect(x)_i + "b") = 1 - xi_i $]]

$C$ 为惩罚因子，利用拉格朗日乘数法可解。

=== 非线性 SVM

希望构造一个映射 $phi.alt$，使得 $phi.alt(vect(x))$ 在高维空间线性可分。

一般将拉格朗日函数对偶处理，对偶后涉及 $phi.alt(vect(x))$ 的内积。一般地，显示给出 $phi.alt$ 较困难，但只需要计算其内积。因此，若存在简单函数 $K(vect(u), vect(v)) equiv phi.alt(vect(u)) dot.c phi.alt(vect(v))$，用 $K$ 代替即可。$K$ 称核函数。

=== 多分类

样本本身为多类别，用二分类拟合。

- #[
    一对一

    共 $m$ 个类别。对 $binom(m, 2)$ 对组合分别构建 SVM。预测时遍历所有 SVM，按划分投票，票数最多的一类为预测结果。

    效率低，效果好。
]

- #[
    一对多

    每次取一个类别，规定其为正类，其它 $m - 1$ 个为负类。建 $m$ 个 SVM。

    分类器少，但正负样本数不平衡。

    解决：对正负样本设不同的惩罚因子。
]

- #[
    层次法

    建二叉树。

    效率高，但误差累积。
]

=== 总结

- #[
    优点

    能处理高维问题；非线性问题。

    泛化能力强，因其最小化结构风险而非经验风险。（简单地，对过拟合有限制。）

    应用场景广。
]

- #[
    缺点

    计算成本高；调参难。

    对异常值敏感。
]

#pagebreak(weak: true)

= #text(size: 二号)[
    回归
]

== #text(size: 小三号)[
    线性回归
]

损失函数：评价单样本误差。e.g. 平方和损失 $L(vect(x)) := 1/2 (h(vect(x)) - y)^2$

代价函数：评价训练集平均误差。e.g. 残差平方和 $J := 1/(2n) sum (h(vect(x)) - y)^2$

目标函数：代价和正则化。$f = J(vect(w)) + lambda Omega(vect(w))$，引入 $lambda$ 来限制过拟合，$Omega$ 为针对结构的函数。\
\

取回归函数 $h(vect(x)) = vect(w) dot.c vect(x) + "b"$，仅以代价函数为目标函数举例。

- #[
    最小二乘法

    无约束极值，求偏导令为零。

    对 $vect(x) in RR$ 的情景
    $ w^* & = (1/n sum x_i y_i - dash(x)dash(y))/(1/n sum x_i^2 - dash(x)^2)\
    b^* & = dash(y) - w^* dash(x)  $

    适合数据集小，维数低。
]

- #[
    梯度下降

    设学习率 $alpha$，迭代 $w arrow.l w - alpha (partial J)/(partial w), space b arrow.l b - alpha (partial J)/(partial b)$

    广泛，但步长 $alpha$ 设置影响迭代速度。
]\
\

评价指标：
- #[
    平均绝对误差 $"MAE" := 1/n sum abs(y_i - hat(y)_i)$

    平均绝对百分比误差 $"MAPE" := 100/n sum abs((y_i - hat(y)_i)/y_i)$
]

- #[
    均方误差 $"MSE" := 1/n sum (y_i - hat(y)_i)^2$
]

- #[
    $R^2$ 评价指标 $R^2:= 1 - (sum (y_i - hat(y)_i)^2)/(sum (y_i - dash(y))^2)$，越大越好
]\
\

广义线性回归：对 $y$ 做映射，使得能线性回归。e.g. $ln y = vect(w) dot.c vect(x) + "b"$\
条件：映射的函数单调可微。

== #text(size: 小三号)[
    逻辑回归
]

用线性回归做二分类，本质并非回归。

用概率分类，按 $> 0.5 \/ <0.5$ 分类。为此需将 $RR arrow [0, 1]$，取 S 型函数 (Sigmoid Function)。其关于 $(0, 0.5)$ 对称，在左右两侧迅速减/增至 0/1。
$ f(x) = 1/(1 + e^(-x)) $

预期值，即当作 $P(vect(x))$。
$ h(vect(x)) = f(vect(w) dot.c vect(x) + "b") $

应用极大似然估计 MLE，求 $vect(w), "b"$ 使得在此分布下 $P(vect(y) = (y_1, dots.c, y_n))$ 最大，其中样本 $y_i in {0, 1}$。
$ & max_(vect(w), "b") L(vect(w), "b") := product P(y_i | x_i) = product [h(vect(x)_i)]^(y_i) [1 - h(vect(x)_i)]^(1 - y_i) \
arrow.l.r.double & max_(vect(w), "b") ln L(vect(w), "b") = sum [y_i ln h(vect(x)_i) + (1 - y_i) ln (1 - h(vect(x)_i))] \
arrow.r.double & min_(vect(w), "b") J(vect(w), "b") := -1/n ln L(vect(w), "b") $

故取损失函数 $L(y, hat(y)) = y_i ln hat(y)_i + (1 - y_i) ln (1 - hat(y)_i)$\
代价函数 $J(vect(w), "b") = -1/n sum L(y, hat(y))$

沿用梯度下降，推导略
$ w & arrow.l & w & - alpha 1/n sum x_i [h(x_i) - y_i] \
b & arrow.l & b & - alpha 1/n sum [h(x_i) - y_i] $

评价指标：\
#grid(columns: 2, column-gutter: 1em, row-gutter: 1em)[
    TP: True Positive 真阳性
][
    FN: False Negative 假阴性
][
    FP: False Positive 假阳性
][
    TN: True Negative 真阴性
]
- 准确率 Accuracy $:= ("TP" + "TN")/("TP" + "FN" + "FP" + "TN")$

- 精准率 Precision $:= "TP"/("TP" + "FP")$

- 召回率 Recall $:= "TP"/("TP" + "FN")$

- $F_"score" := (1 + beta^2) ("Precision" dot.c "Recall")/(beta^2 dot.c "Precision" + "Recall")$，为精准率与召回率的加权调和平均。
精准率与召回率都是对钦定的正类而言。

- #[
    优点

    形式简单，可解释性好；易于并行；资源占用小，尤见于内存；方便输出结果调整。
]

- #[
    缺点

    表达能力不强；准确率不高；处理非线性预测难。
]

#pagebreak(weak: true)

= #text(size: 二号)[
    神经网络
]