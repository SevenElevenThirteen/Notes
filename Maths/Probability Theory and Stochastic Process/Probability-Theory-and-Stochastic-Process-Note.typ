/* packages */
#import "../../__Template/Typst-Template/Packages-for-Typst-Template.typ": *
#show: environment

/* abbrs */
#import "../../__Template/Typst-Template/Abbrs-for-Typst-Template.typ": *
#let proof = proof-template.with(prefix: [证明：]) // more recommended by GPT 5.6 Luna, and get ce when try to use set/show
#let example = proof-template.with(prefix: [e.g.])
#let dist-law = proof-template.with(prefix: [d.l.])

#let var = "Var"
#let cov = $C o v$

/*
    字体设置
    Times New Roman 不支持中文
    NSimSun 新宋体
    默认小四号
*/
#set text(
    font: ("Times New Roman", "NSimSun"),
    size: 小四
)

/*
    页面设置
    A4
    页边缘：上下 2.54cm；左右 1.91cm
*/
#set page(
    paper: "a4",
    margin: (x: 2.54cm, y: 1.91cm), 
    numbering: "1"
)

/* specific math abbr. */
#let opp(x) = math.overline(x)
#let upr(x) = math.upright(x)
#let eve(x, y) = $upright(#x)_(#y)$

#let upra = $upr(A)$
#let uprb = $upr(B)$
#let oppa = $opp(upr(A))$
#let oppb = $opp(upr(B))$

#page(numbering: none)[
    #align(center + horizon)[

        #text(size: 40pt)[
            #set par(spacing: 40pt)
            
            Probability Theory

            &

            Stochastic Process
        ]

        #v(1em)
        #text(size: 20pt)[
            1001
        ]

        #v(6em)
        #text(size: 20pt)[
            #datetime.today().display()
        ]
    ]
]
#counter(page).update(1)

#set heading(numbering: "A.a.1.")

#set align(center)
#text(size: 四号)[
    #outline(
        title: [
            #v(0.5em)
            #text(size: 初号)[目录]
            #v(1em)
        ],
        indent: n => n * 1em,
        depth: 3 // only Part, Chapter & Section will display
    )
]

#pagebreak()
#counter(page).update(1)
#set align(start)

#show heading: it => {
    let arr = counter(heading).get()
    
    if it.level == 1 {
        pagebreak(weak: true)
        set align(center)
        set text(size: 初号)
        it
        v(1em)
    }
    else if it.level == 2 {
        set align(center)
        set text(size: 二号)
        it
    }
    else if it.level == 3 {
        it
    }
    else {
        it.body
    }
}

= 基础

== 随机事件及运算

=== 随机事件

随机试验：可重复，所有可能结果可知，结果不可预知。
Trial / Experiment, T/E

样本空间 $SS$：样本点的集合

事件 $A subset SS$：样本空间的子集，触发任意一个样本点均属发生 \
基本事件 ${e}$ \
不可能事件 $emptyset$ \
必然事件 $SS$

=== 事件的关系

#table(
    columns: 3, 
    [$A subset B$], [$B$ 包含 $A$], [$A$ 发生 $arrow$ $B$ 发生], 
    [$A = B$], [$A$ 和 $B$ 相等], [$A subset B and B subset A$], 
    [], [$A$ 和 $B$ 互不相容/互斥], [$A B = emptyset$],
    [], [$A$ 和 $B$ 互为对立事件], [$A union B = SS and A inter B = emptyset$]
)

=== 事件的运算

#table(
    columns: 3,
    [$A union B$], [和事件], [$A$ 和 $B$ 有一个发生], 
    [$A inter B slash A B$], [积事件], [$A$ 和 $B$ 都发生], 
    [$A - B$], [差事件], [$A$ 发生 $B$ 不发生], 
    [$opp(A)$], [逆事件], [$A$ 不发生]
)

运算律：
- 交换律，结合律，分配律
- De Morgan's：对至多可列个事件，$opp(union.big A) = inter.big opp(A)$，$opp(inter.big A) = union.big opp(A)$

汉语转化为式子：从后往前（a.k.a. 定语从内到外），有 #imply $union$；量词；否定 #imply $opp(A)$

== 事件的概率

- 客观概率：事件可多次重复，如“抛硬币正面的概率”。
- 主观概率：事件不可多次重复，如“明天下雨的概率”。

=== 历史

==== 统计定义

$n to oo space f_n (A) to P(A)$ 频率估计概率。

==== 古典概型

基本事件概率必须一样。

- #[
    放球问题：$n$ 个球 $N$ 个盒

    球在哪个盒：$SS_1 = {(p_1, dots.c, p_n): p_i in [1, N] inter NN}$

    盒有哪些球：$SS_2 = {(S_1, dots.c, S_N): S_i subset [1, n] inter NN, S_i inter S_j = emptyset, union.big S_i = [1, n] inter NN}$
]

- 生日悖论

==== 几何概型

古典概型推广，记 $L$ 为度量，$P(A) := (L(A))/(L(Omega))$

Bertrand Paradox：单位圆随机弦，长度超过内接等边三角形边长 $sqrt(3)$ 的概率？
- 定一点 $A$，圆上随机取 $B$：$P = 1/3$
- 弦心距 $< 1/2$：$P = 1/2$
- 弦中点在 $r = 1/2$ 的小圆内：$P = 1/4$

=== 公理化

$cal(F)$ 为样本空间 $Omega$ 上的 $sigma$-代数（$tilde cal(F) = 2^Omega$），$P: cal(F) arrow.r.hook RR$，若 $P$ 满足：
#[
    #set enum(numbering: "a.")
    + $forall A in cal(F)$, $P(A) gt.slant 0$
    + $P(Omega) = 1$
    + #[
        可列可加性：
        若 $A_i in cal(F)$, $i = 1, dots.c$ 满足 $A_i inter A_j = emptyset$，则
        $ P(union.big_(i = 1)^oo A_i) = sum_(i = 1)^oo P(A_i) $
    ]
]
则称 $P$ 为定义在 $(Omega, cal(F))$ 上的概率，概率空间 $(Omega, cal(F), P)$

性质：
+ #[
    $P(emptyset) = 0$
]

+ #[
    若 ${A_n}$ 为一列两两互不相容事件，则
    $ P(union.big_(i = 1)^n A_i) = sum_(i = 1)^n P(A_i) $

    证明：补 $emptyset$，但需说明 $A_i ' A_j ' = emptyset$
]
+ #[
    $P(A) = 1 - P(opp(A))$
]
+ #[
    单调性：若 $A subset B$，则 $P(B - A) = P(B) - P(A)$，于是 $P(A) leq P(B)$
]
+ #[
    $P(A union B) = P(A) + P(B) - P(A B)$

    推广：$ P(union.big_(i = 1)^(n) A_i) = sum_(S subset {1, dots.c, n}) (-1)^(|S| - 1) P(product_(i in S) A_i) $

    证明：$A union B = A union (B - A B)$，二者互不相容。又 $A B subset B$，$P(B - A B) = P(B) - P(A B)$
]
+ #[
    连续性：\
    a. 若 $A_1 subset A_2 subset dots.c$，记 $A = union.big A_i$，则 $P(A) = lim P(A_i)$ \
    b. 若 $A_1 supset A_2 supset dots.c$，记 $A = inter.big A_i$，则 $P(A) = lim P(A_i)$

    #proof()[
        a. 单调有界有极限。取 $B_1 = A_1, B_i = A_i - A_(i - 1)$，则 $A = union.big B_i$。

        b. 依单调性，$P(A_1) geq P(A_2) geq dots.c geq P(A) geq 0$。
    ]
]

== 条件概率

=== 定义

给定 $(Omega, cal(F), P)$，设事件 $B$ 满足 $P(B) > 0$，定义映射
$ P(ast | B): cal(F) arrow.hook RR\
P(A | B) arrow.bar P(A B)/P(B) $
依次验证 $P(ast | B)$ 满足公理化的 3 个条件，故其确为概率，称条件概率。继而概率的 6 条性质可以迁移到条件概率。

// === 公式

=== 乘法公式

$P(B) > 0$ 时，$P(A B) = P(A) times P(A | B) = P(B) times P(B | A)$

推广：若 $P(A_1 dots.c A_(n - 1)) > 0$，则
$ P(A_1 dots.c A_n) = P(A_1) times P(A_2 | A_1) times P(A_3 | A_1 A_2) times dots.c times P(A_n | A_1 dots.c A_(n - 1)) $

于是 $n$ 个事件的交可视为 $n$ 个事件依次发生。

=== 全概率公式

一个 $SS$ 的划分 ${B_n}$ 是满足如下条件的一列事件：\
a. $B_i B_j = emptyset$ \
b. $union.big B_i = SS$

取一列划分 ${B_n}$，则：
$ P(A) = sum P(A | B_i) P(B_i) $
#proof()[
    $A = A SS = A (union B_i) = union (A B_i)$，而 $(A B_i) inter (A B_j) = emptyset$。由可列可加性展开，再基于乘法公式。
]

推论：$min{P(A | B_i)} leq P(A) leq max{P(A | B_i)}$

=== 贝叶斯公式

- #[
    两枚硬币：一枚正反一样，一枚正常。等概率随机取一枚，在连抛两次都是正面的条件下，第三次是正面的概率？

    记事件 $eve(A, i)$ 为第 $i$ 次为正面，$upr(F)$ 为使用正常硬币。已知 $P(eve(A, ast) | upr(F)) = 1/2 en P(eve(A, ast) | opp(upr(F))) = 1$

    在第一次实验前：$P(upr(F)) = 1/2 en P(opp(upr(F))) = 1/2$

    在第一次实验后 a.k.a. 第二次实验前：
    $ P(upr(F) | eve(A, 1)) &= P(upr(F)eve(A, 1))/P(eve(A, 1))
    = (P(eve(A, 1) | upr(F)) P(upr(F)))/(P(eve(A, 1) | upr(F)) P(upr(F)) sp + sp P(eve(A, 1) | upr(opp(F))) P(opp(upr(F)))) \
    &= (1/2 times 1/2)/(1/2 times 1/2 + 1 times 1/2) = 1/3 $

    第二次实验后，将其视为在第一次基础上的实验，第一次的后验概率变为第二次的先验概率：（形式上，所有推演套在 $P(ast | eve(A, 1))$ 中。亦可看作 $P(upr(F) eve(A, 1) eve(A, 2))  slash P(eve(A, 1) eve(A, 2))$ *上下同除* $P(eve(A, 1))$。）
    $ P(upr(F) | eve(A, 1) eve(A, 2)) &= (P(upr(F) eve(A, 2) | eve(A, 1)))/(P(eve(A, 2) | eve(A, 1)))
    = (P(eve(A, 2) | upr(F) eve(A, 1)) P(upr(F) | eve(A, 1)))/(P(eve(A, 2) | upr(F) eve(A, 1)) P(upr(F) | eve(A, 1)) + P(eve(A, 2) | opp(upr(F)) eve(A, 1)) P(opp(upr(F)) | eve(A, 1))) \
    &= (1/2 times 1/3)/(1/2 times 1/3 + 1 times 2/3) = 1/5 $
    
    另一方面，把第一次的式子代入第二次：
    $ &quad P(upr(F) | eve(A, 1) eve(A, 2)) \
    &= (P(eve(A, 2) | upr(F) eve(A, 1)) P(upr(F) | eve(A, 1)))/(P(eve(A, 2) | upr(F) eve(A, 1)) P(upr(F) | eve(A, 1)) + P(eve(A, 2) | opp(upr(F)) eve(A, 1)) P(opp(upr(F)) | eve(A, 1))) \
    &= (P(eve(A, 2) | upr(F) eve(A, 1)) times (P(eve(A, 1) | upr(F)) P(upr(F)))/(P(eve(A, 1) | upr(F)) P(upr(F)) + P(eve(A, 1) | upr(opp(F))) P(opp(upr(F)))))/(P(eve(A, 2) | upr(F) eve(A, 1)) times (P(eve(A, 1) | upr(F)) P(upr(F)))/(P(eve(A, 1) | upr(F)) P(upr(F)) + P(eve(A, 1) | upr(opp(F))) P(opp(upr(F)))) + P(eve(A, 2) | opp(upr(F)) eve(A, 1)) times (P(eve(A, 1) | opp(upr(F))) P(opp(upr(F))))/(P(eve(A, 1) | upr(F)) P(upr(F)) + P(eve(A, 1) | upr(opp(F))) P(opp(upr(F)))))\
    &= (P(eve(A, 2) | upr(F) eve(A, 1)) P(eve(A, 1) | upr(F)) P(upr(F)))/(P(eve(A, 2) | upr(F) eve(A, 1)) P(eve(A, 1) | upr(F)) P(upr(F)) sp + sp P(eve(A, 2) | opp(upr(F)) eve(A, 1)) P(eve(A, 1) | opp(upr(F))) P(opp(upr(F))))\
    &= (1/2 times 1/2 times 1/2)/(1/2 times 1/2 times 1/2 + 1 times 1 times 1/2) = 1/5 $

    可见使用两次贝叶斯公式和使用一次是等价的。

    最后，
    $ P(eve(A, 3) | eve(A, 1) eve(A, 2)) &= P(eve(A, 3) | upr(F) eve(A, 1) eve(A, 2)) P(upr(F) | eve(A, 1) eve(A, 2)) + P(eve(A, 3) | opp(upr(F)) eve(A, 1) eve(A, 2)) P(opp(upr(F)) | eve(A, 1) eve(A, 2)) \
    &= 1/2 times 1/5 + 1 times 4/5 = 9/10 $
]

#divider()

记 ${B_n}$ 为 $SS$ 的一个划分，若 $P(upr(A)) > 0$ 且 $forall i, P(B_i) > 0$，则：
$ P(B_t | upr(A)) = (P(upr(A) B_t))/(P(upr(A))) = (P(upr(A) | B_t) P(B_t))/(sum P(upr(A) | B_i) P(B_i)) $
核心源自乘法公式的交换性 Exchangability，算两次：$P(A B) = P(A) times P(A | B) = P(B) times P(B | A)$

推论：找主要原因看*乘积*而非单项 Product Matters !
$ arg max_t P(B_t | upr(A)) &= arg max_t (P(upr(A) | B_t) P(B_t))/(sum P(upr(A) | B_i) P(B_i)) \
&= arg max_t P(upr(A) | B_t) P(B_t) $

假设现有一列样本 ${x_n}$，视为一次实验与 $n$ 次连续实验是等价的，这称贝叶斯公式的相合性 Coherence。证明无非展开与归纳。于是可以递推 Recursive：
$ P(theta_t | x_1 dots.c x_(n + 1)) = (P(x_(n + 1) | theta_t sp x_1 dots.c x_n) times P(theta_t | x_1 dots.c x_n))/(sum P(x_(n + 1) | theta_i sp x_1 dots.c x_n) times P(theta_i | x_1 dots.c x_n)) $

若 $P(x_(n + 1) | theta sp x_1 dots.c x_n) equiv P(?|theta)$（实验相互独立？），则运算只是对右侧的反复替换。

== 独立性

=== 两个事件的独立性

若事件 $upright(A), upright(B)$ 满足
$ P(upright(A B)) = P(upright(A)) P(upright(B)) $
则称 A, B 为相互独立的事件 / A, B 相互独立。

独立性依赖概率：如考虑 $Omega = {1, 2, 3, 4}$，$cal(F) = 2^Omega$，$upr(A) = {1, 2}, upr(B) = {1, 3}$
- #[
    $P_1: P_1({1}) = P_1({2}) = P_1({3}) = P_1({4}) = 1/4$

    $ cases(reverse: #true,
        P(upr(A B)) = P({1}) = 1/4,
        P(A) = P(B) = 1/2) imply P(upr(A B)) = P(upr(A)) P(upr(B)) $
]
- #[
    $P_2: P_1({1}) = 1/2, P_1({2}) = P_1({3}) = 1/4,  P_1({4}) = 0$

    $ cases(reverse: #true,
        P(upr(A B)) = P({1}) = 1/2,
        P(A) = P(B) = 1/2 + 1/4 = 3/4) imply P(upr(A B)) != P(upr(A)) P(upr(B)) $
]

性质：
+ #[
    若 $upr(A), upr(B)$ 相互独立，则 $opp(upr(A)), upr(B)$、$upr(A), opp(upr(B))$ 和 $opp(upr(A)), opp(upr(B))$ 均相互独立。

    只需说明 $upr(A), upr(B) imply opp(upr(A)), upr(B)$，其它均由其替换而得。$upr(B) = upr(A B) union opp(upr(A))upr(B) and (upr(A B)) inter (opp(upr(A))upr(B)) = emptyset$，于是 $P(upr(B)) = P(upr(A B)) + P(opp(upr(A))upr(B)) = P(upra)P(uprb) + P(oppa uprb)$。移项 $P(oppa uprb) = P(uprb)(1 - P(upra)) = P(oppa)P(uprb)$。
]

+ #[
    若 $P(upr(A)) > 0, P(upr(B)) > 0$，则 $upr(A), upr(B)$ 相互独立，与 $upr(A), upr(B)$ 互不相容不能同时成立。

    若同时成立，则 $P(upr(A)) P(upr(B)) =^("独立性") P(upr(A B)) =^("互不相容") P(emptyset) = 0$，与 $P(upr(A)) > 0, P(upr(B)) > 0$ 矛盾。
]
+ #[
    若 $P(upr(A)) > 0$，则 $upr(A), upr(B)$ 相互独立的*充要条件*是
    $ P(upr(B) | upr(A)) = P(upr(B)) $
]

=== 多个事件的独立性

==== 两两独立

若一列事件 ${upr(A)_n}$ 满足 $ P(upr(A)_i upr(A)_j) = P(upr(A)_i) P(upr(A)_j) med forall i != j $
称 ${upr(A)_n}$ 两两独立。

两两独立*不一定* $P(product upr(A)) = product P(upr(A))$。如掷两次骰子，$upra$ 为第一次为偶数，$uprb$ 为第二次为奇数，$upr(C)$ 为两次奇偶性相同。可得 $P(upra) = P(uprb) = P(upr(C)) = 1/2$，$P(upra uprb) = P(upra upr(C)) = P(uprb upr(C)) = 1/4$ 故两两独立。但显然 $P(upra uprb upr(C)) = 0$。

==== 相互独立

若一列事件 ${upr(A)_n}$ 满足 $ P(product_(i in S) upr(A)_i) = product_(i in S) P(upr(A)_i) med forall S subset {1, dots.c, n} and |S| geq 2 $
称 ${upr(A)_n}$ 相互独立。

性质：
+ #[
    若 ${upr(A)_n}$ 相互独立，则从中任取 $m leq n$ 个事件，这些事件也相互独立。
]

+ #[
    若 ${upr(A)_n}$ 相互独立，则把任意 $m leq n$ 个事件 $upr(A)_i$ 换成其对立事件 $opp(upr(A)_i)$，这些事件仍相互独立。

    只需说明换一个 $upra to oppa$ 无影响，而其证明与两个事件的情景本质相同。
]

== 伯努利试验

- #[
    伯努利试验：结果只有 $upra slash oppa$，$P(upra) = p$
]

- #[
    $n$ 重伯努利试验：满足如下约定：
    + #[结果只有 $upra slash oppa$。]
    + #[$P(upra_i) equiv p$（概率不变）。]
    + #[$upra_1, dots.c, upra_n$ 相互独立 / $n$ 次试验相互独立。]
    + #[进行了 $n$ 次。]
]

$n$ 次发生 $k$ 次：$P = binom(n, k) med p^k med q^(n - k) quad (q = 1 - p)$

= 一元随机变量

== 定义

=== 随机变量

$X: Omega to RR$，则 ${omega in Omega: X(omega) leq x} in cal(F)$ 是一个事件，简记为 ${X leq x}$

$P{X leq x}$ 是 $P compose X: RR to^X Omega to^P RR$ 的映射。

随机变量 r.v. (random variable) $X, Y, Z, dots.c$ 本质是映射。

=== 分布函数

分布函数 d.f. (distribution function) $F_X (x) := P{X leq x}$

e.g. 抛一次硬币，记 $X$ 为正面的次数，且令正面向上的概率为 0.7。则 $ F_X (x) = cases(0 &x < 0, 0.3 sp &0 leq x < 1, 1 &x geq 1) $

性质：
+ #[
    $F(x)$ 不减。
]

+ #[
    $lim_(x to -oo) F(x) = 0$, $lim_(x to +oo) F(x) = 1$

    $F(x)$ 单调且有界，$x to oo slash -oo$ 的极限均存在。$emptyset subset dots.c subset {X leq x} subset dots.c subset Omega$，前者逼近 $emptyset$，后者逼近 $Omega$。
]
+ #[
    $F(x)$ 右连续，即 $F(x) = F(x^+)$。

    取一列 ${x_n} to x_0^+$，有 ${X leq x_1} supset {X leq x_2} supset dots.c supset {X leq x_0}$，依概率的连续性可得。而 $F(x)$ 不一定左连续，见上例。
]

间断点不可去，事实上 $x_0$ 处间断说明 $P(X = x_0) > 0$。

若函数 $f: RR to RR$ 满足分布函数的三条性质，则存在 $(Omega, cal(F), P)$ 和 $X: Omega to RR$ 满足其分布函数恰为 $f$。

计算：
+ #[
    $P(a < X leq b) = F(b) - F(a)$
]

+ #[
    $P(X = b) = F(b) - F(b^-)$
]

离散型和连续性不构成随机变量的分类。

== 离散型随机变量

=== 定义

$X$ 的取值是至多可列种。

分布律 d.l. (distribution law): $P(X = x_k) = p_k quad k = 1, dots.c$

d.f. $F(x) = sum_(x_k leq x) p_k$

// === 常见分布

=== 0-1 分布

扔一次硬币，正面概率 $p$，正面次数 $X in {0, 1}$。

$X tilde (0-1)$

d.l. $P{X = k} = p^k (1 - p)^k quad k in {0, 1}$

=== 二项分布

同一枚硬币扔 $n$ 次，正面概率均为 $p$，正面次数 $X in {0, dots.c , n}$。

$X tilde b(n, p)$

$X = sum X_i quad X_i tilde (0-1)$

#dist-law()[
    $P{X = k} = display(binom(n, k) p^k q^(n - k)) to^"Poisson" (n p)^k/(k!)exp(-n p)$
    
    单峰 $(n + 1)p - 1 leq k leq (n + 1)p$ a.k.a. $floor((n + 1)p) sp slash sp ceil((n + 1)p)$
]

=== 泊松分布

泊松定理：若 $n p_n = lambda$ 为常数且 $X_n tilde b(n, p_n)$，则
$ lim_(n to oo) P{X_n = k} = (lambda^k exp(-lambda))/(k!) $
#proof()[
    $ & quad lim_(n to oo) binom(n, k) p^k q^(n - k)\ &= lim_(n to oo)(n(n - 1) dots.c (n - k + 1))/(k!) (lambda/n)^k (1 - lambda/n)^(n - k)\
    &= lim_(n to oo) lambda^k / k! dot (1 - lambda/n)^n dot (1 - lambda/n)^(-k) dot [1 (1 - 1/n)(1 - 2/n) dots.c (1 - (k - 1)/n)]\
    &= lambda^k / k! dot e^(-k) dot 1 dot 1 = lambda^k / k! exp(-lambda) $
]

$X tilde pi(lambda)$

d.l. $P{X = k} = display((lambda^k exp(-lambda))/(k!))$

#example()[
    $X tilde pi(lambda)$, $Y tilde pi(mu)$，则 $Z = X + Y tilde pi(lambda + mu)$
]

=== 几何分布

重复独立进行伯努利试验，直到 $upra$ 出现（其概率为 $p$）。试验次数 $X in NN_+ union {oo}$

考虑事件“$upra$ 从未发生”，可记为 ${X = oo}$，需说明 $P{X = oo} = 0$。
- #[
    取 $union_(k = 1)^oo {X = k}$，这不含 ${X = oo}$。$P{X = oo} = 1 - P(union_(k = 1)^oo {X = k})$
]
- #[
    取 $lim_(k to oo) {X geq k}$，这包含 ${X = oo}$。$P{X = oo} = lim_(k to oo) P{X geq k}$
]

#dist-law()[
    $P{X = k} = p q^(k - 1)$

    $P{X > k} = p q^k (1 + q + q^2 + dots.c) = p q^k 1/(1 - q) = q^k$
]

无记忆性：
$ P{X > m + n | X > m} &= P{X > m + n, X > m}/P{X > m} = P{X > m + n}/P{X > m}\
&= (p q^(m + n) (1 + q + q^2 + dots.c))/(p q^m (1 + q + q^2 + dots.c)) = q^n \
&= P{X > n} $

几何分布具有无记忆性，反之具有无记忆性的随机变量必然为几何分布（$p_(m + n) = p_m p_n imply {p_n}$ 为指数数列）

无记忆性源自独立、同分布。

=== 帕斯卡分布

概率为 $p$ 的伯努利试验，$upra$ 出现 $r$ 次时的试验次数 $X in {r, r + 1, dots.c}$

d.l. $P{X = k} = binom(k - 1, r - 1) p^r q^(k - r)$

记 $X_i$ 为在出现 $i - 1$ 次 $upra$ 后，出现第 $i$ 次 $upra$ 的试验次数，则 $X_i$ 服从几何分布\
$X = sum X_i$

=== 超几何分布

$N$ 件物品中 $M leq N$ 件有标记，不放回地取出 $n leq N$ 件物品，有标记的物品数量 $X in {0, dots.c, min{n, M}}$

d.l. $P{X = k} = display((binom(M, k)binom(N - M, n - k))/binom(N, n)) quad 0 leq k leq min{n, M}$

== 连续型随机变量

=== 定义

称 $X$ 为连续型随机变量，若存在 $f(x) geq 0$ 使其分布函数 $F(x)$ 满足
$ F(x) = integral_(-oo)^x f(t) dif t $
称 $f(x)$ 为概率密度函数 p.d.f. (probability density function)

事件：随机点落到确定区间

$F(x)$ 性质：
+ #[$F(x)$ 连续；]
+ #[$P{X = a} = 0$（但概率为0/1不代表不可能/必然事件）]

$f(x)$ 性质：
+ #[$F(x) = integral_(-oo)^x f(x) dif x$, $f(x) = F'(x)$]

// === 常见分布

=== 均匀分布

若 $X$ 具有概率密度
$ f(x) = cases(1/(b - a) & sp x in (a, b), 0 & sp x in.not (a, b)) $
称 $X$ 服从均匀分布。

$X tilde U(a, b)$

r.v. X, satisfy:
+ #[If $(a, b) subset overline((c, d))$, $P{a < X < b} = 0$]
+ #[If $(a, b) subset (c, d)$, $P{a leq X leq b} prop (b - a)$]
prove that $X tilde U(c, d)$ (trivial)

=== 指数分布

（在短期内，）“寿命”具有无记忆性，当前不受历史的影响。实际意义是外因固定（？）。$lambda$ 表示单位时间内 $upra$ 发生的次数（e.g. 选定一个群体 $N$，那么单位时间后会有 $N lambda$ 次，如死亡率）。

p.d.f.
$ f(x) = cases(lambda exp(-lambda x) & sp x > 0, 0 & sp x leq 0) $

d.f.
$ F(x) = cases(1 - exp(-lambda x) & sp x > 0, 0 & sp x leq 0) $

$P{X > k} = 1 - F(k) = exp(-lambda k)$

无记忆性：$P{X > m + n | X > m} = P{X > n}$
#proof()[
    $ P{X > m + n | X > m} &= P{X > m + n, X > m}/P{X > m} = P{X > m + n}/P{X > m}\
    &= exp(-lambda (m + n))/exp(-lambda m) = exp(-lambda n)\
    &= P{X > n} $
]

若 r.v. $X$ 满足如下条件，则服从指数分布：
+ #[$forall x < 0$, $F_X (x) = 0$]
+ #[无记忆性]
+ #[连续函数]
#proof()[$g(x + y) = g(x) g(y)$，在 $QQ$ 上为指数函数，连续则 $RR$ 上也是。]

#example()[
    若元件在 $t$ 时间内发生故障的次数 $N(t) tilde pi(lambda t)$，那么相邻两次故障间隔 $T$ 服从指数分布。

    $P{T > t} = P{N(t) = 0} = (lambda t)^0 / 0! exp(-lambda t) = exp(-lambda t)$

    $F(t) = P{T leq t} = 1 - exp(-lambda t)$
]

=== 正态分布

#example()[
    $f(x) = exp(A x^2 + B x + C)$ 是某随机变量 $X$ 的概率密度函数，$A, B, C$ 关系？

    $C$ 用于调面积。$A > 0$ 时显然发散；$A = 0$ 时，$exp(B x)$ 也发散（于是指数分布只能定义半个实轴）；因此 $A < 0$。

    考虑用高斯积分处理 $exp(-x^2)$，于是配方 $A x^2 + B x = A(x + B/(2A))^2 -B^2/(4A)$
    
    换元 $t = sqrt(-A)(x + B/(2A))$，$dif t = sqrt(-A) dif x$，于是
    $ integral_(-oo)^(oo) exp(A x^2 + B x) dif x &= integral_(-oo)^(oo) exp(-t^2 - B^2/(4A)) dot 1/sqrt(-A) dif t\
    &= 1/sqrt(-A) exp(-B^2/(4A)) integral_(-oo)^(oo) exp(-t^2) dif t\
    &= exp(-B^2/(4A)) sqrt(pi/(-A)) $

    为使其成为概率密度函数，需
    $ exp(C - B^2/(4A)) sqrt(pi/(-A)) = 1 imply C = ln sqrt(-A/pi) + B^2/(4A) $

    凑正态分布公式。记 $sigma = 1/sqrt(-2A)$，则 $A = -1/(2 sigma^2)$；记 $mu = sigma^2 B$，则 $B = mu/sigma^2$，进而有
    $ C = ln sqrt(1/(2 pi sigma^2)) + mu^2/sigma^4 dot (-sigma^2/2) = ln 1/(sigma sqrt(2 pi)) - mu^2/(2 sigma^2) $

    带回原式：
    $ f(x) &= exp(A x^2 + B x + C) = exp(-1/(2 sigma^2) x^2 + mu/sigma^2 x + ln 1/(sigma sqrt(2 pi)) - mu^2/(2 sigma^2))\
    &= 1/(sigma sqrt(2 pi)) exp(-1/(2 sigma^2) x^2 + mu/sigma^2 x - mu^2/(2 sigma^2))\
    &= 1/(sigma sqrt(2 pi)) exp(-1/2 ((x - mu)/sigma)^2) $

    这即正态分布。
]

p.d.f.
$ f(x) = 1/(sigma sqrt(2 pi)) exp(-1/2 ((x - mu)/sigma)^2) $

$X tilde N(mu, sigma^2)$, $sigma > 0$

换元 $t = (x - mu)/sigma$, $dif x = sigma dif t$，则
$ integral_(-oo)^oo f(x) dif x &= integral_(-oo)^oo 1/sqrt(2 pi) e^(-1/2 t) dif t $

标准正态分布 $X tilde N(0, 1)$，特别地，其概率密度/分布函数用 $phi slash Phi$

- #[
    一张表
    $ integral_(a)^b f(x) dif x &= integral_(-a)^b 1/sqrt(2 pi) e^(-1/2 t) dif t \
    &=^(t = (x - mu) slash sigma) integral_((a - mu)/sigma)^((b - mu)/sigma) phi(t) dif t \
    &= Phi((b - mu)/sigma) - Phi((a - mu)/sigma) $
]
- #[
    $Phi(-z) = 1 - Phi(z)$ 这对任意偶函数均成立。
]
- #[
    $P{abs(X - mu) leq sigma} = 68.3%$\
    $P{abs(X - mu) leq 2 sigma} = 95.4%$\
    $P{abs(X - mu) leq 3 sigma} = 99.7%$
]

== 随机变量的函数

=== 定义
r.v. $X: Omega to RR^n$, 连续函数 $g: RR^n to RR^m$, $g(X): Omega to RR^m$

// === 做法

=== 离散型

trivial

=== 连续型

为求 $Y = g(X)$ 的 p.d.f. $f_Y$，先求 d.f. $F_Y$，另记 $I_y = {x: g(x) leq y}$

$F_Y (y) = P{Y leq y} = P{g(X) leq y} = P{X in I_y} = integral_(I_y) f_X (x) dif x = integral_(g(X) leq y) f_X (x) dif x$

之后 $f_Y (y) = dif/(dif y) F_Y (y)$

用 $F_X (x)$ 暂存 $integral_(g(X) leq y) f_X (x) dif x$，再用链式法则打开，省去一步积分。

#example()[
    r.v. $X$, p.d.f. $f_X (x)$，求 $Y = X^2$

    $y leq 0$: $F_Y (y) = 0 sp imply sp f_Y (y) = 0$

    $y > 0$:
    $ F_Y (y) &= P{-sqrt(y) leq X leq sqrt(y)}\
    &= F_X (sqrt(y)) - F_X (-sqrt(y))\
    f_Y (y) &= dif/(dif y) F_Y (y) = f_X (sqrt(y)) dot 1/(2sqrt(y)) - f_X (-sqrt(y)) dot (-1)/(2 sqrt(y)) quad "(chain rule)"\
    &= (f_X (sqrt(y)) + f_X (-sqrt(y)))/(2 sqrt(y)) $
]
#example()[
    r.v. $X tilde N(mu, sigma^2)$，证明 $Y = a X + b sp (a != 0)$ 也服从正态分布

    不妨 $a > 0$，
    $F_Y (y) = P{a X + b leq y} = P{X leq (y - b)/a} = F_X ((y - b)/a)$

    $ f_Y (y) &= dif/(dif y) F_X ((y - b)/a) = f_X ((y - b)/a) dot 1/a\
    &= 1/(sigma sqrt(2 pi)) exp( (( (y - b)/a -mu)/sigma)^2 ) dot 1/a\
    &= 1/((a sigma) sqrt(2 pi)) exp(( (y - (a mu + b))/(a sigma) )^2) $

    于是 $Y tilde N(a mu + b, a sigma)$
]

=== 生成随机数

记 r.v. $X$ 的 d.f. $F_X (x): RR to [0, 1]$，考虑 r.v. $Y = F_X (x)$

$ F_Y (y) &= P{F_X (x) leq y} = P{x leq F^(-1) (y)} = F_X ( F_X^(-1) (y) ) = y $

于是 $Y tilde U(0, 1)$。对于任意分布 $F_X$，只需均匀分布 $[0, 1]$ 上的随机数 $y$，取 $x = F_X^(-1) (y)$ 即得。

= 多元随机变量

== 定义

$X: Omega to RR^n$, $omega hookto (X_1 (omega), dots.c, X_n (omega))$

=== 联合分布

（联合）分布函数 $F(x_1, dots.c, x_n) = P{X_1 leq x_1, dots.c, x_n leq x_n} = P( inter.big {X_i leq x_i} )$

性质：
+ #[$F(x, y)$ 关于 $x slash y$ 均不减]

+ #[
    $F(-oo, y) = F(x, -oo) = 0$, $F(+oo, +oo) = 1$

    $0 leq F(x, y) leq F(x, +oo) = F_X (x)$，令 $x to -oo$ 得 $F(-oo, y) to 0$
]
+ #[$F(x, y)$ 关于 $x slash y$ 均右连续]
+ #[
    $forall (x_1, y_1) leq (x_2, y_2)$, $F(x_2, y_2) - F(x_1, y_2) - F(x_2, y_1) + F(x_1, y_1) geq 0$
]

计算：
+ #[
    $P{x_1 < X leq x_2, y_1 < Y leq y_2} = F(x_2, y_2) - F(x_1, y_2) - F(x_2, y_1) + F(x_1, y_1)$
]
+ #[
    $P(inter.big {l_i < X_i leq r_i}) = sum (-1)^(|S|) F(r_i, l_j) sp forall i in S, j in.not S$
]

=== 边缘分布

$F_X (x) sp slash sp F_Y (y)$ 是 $(X, Y)$ 关于 $X slash Y$ 的边缘分布函数。

$F_X (x) = F(x, +oo)$

== 离散型

（联合）分布律 $P{X = x_i, Y = y_j} = p_(i j)$

边缘分布律 $p_(i dot) = P{X = x_i} = sum_j p_(i j)$

- #[
    一般地，记 $X in {x_n}, Y in {y_m}$，并假设 $n, m geq 2$ 以排除无趣情况。若仅知边缘分布律 ${p_(i dot)}, {p_(dot j)}$，有 $n + m$ 个方程和 $n m$ 个未知数，显然通常不能唯一解出。考虑 $n = m = 2$，此时 $n m = n + m$，是否唯一确定？

    通常不能。记方程为 $r_(1, 2), c_(1, 2)$，有 $r_1 + r_2 = c_1 + c_2 = sum sum p_(i, j)$，方程组线性相关，于是无唯一解。然而有限制 $p_(i, j) geq 0$，特殊情况下解唯一。e.g. $p_(0 dot) = p_(dot 0) = 0, p_(1 dot) = p_(dot 1) = 1 sp imply sp p_(1 1) = 1$
]

== 连续型

=== 定义

（联合）概率密度 $f(x, y)$ s.t. $F(x, y) = integral_(-oo)^x integral_(-oo)^y f(u, v) dif u dif v$

性质：
+ #[
    若 $f(x, y)$ 在 $(x, y)$ 连续，则 $f(x, y) = (partial^2 F)/(partial x partial y) (x, y)$
]

边缘概率密度 $f_X (x) = integral_(-oo)^(oo) f(x, y) dif y$

=== 均匀分布

记区域 $G subset R^2$ 的面积为 $S$，则
$ f(x, y) = cases(1/S sp &(x, y) in G, 0 &(x, y) in.not G) $

=== 正态分布

$ f(x, y) = &1/(2 pi sigma_X sigma_Y sqrt(1 - rho^2)) times\ &exp(-1/(2 (1-rho^2)) (((x - mu_X)/sigma_X)^2 - 2 rho (x - mu_X)/sigma_X (y - mu_Y)/sigma_Y + ((y - mu_Y)/sigma_Y)^2)) $

$(X, Y) tilde N(mu_X, mu_Y, sigma_X^2, sigma_Y^2, rho)$

$rho in [-1, 1]$ 为相关系数，$rho = "cov"(X, Y)/(sigma_X sigma_Y)$

==== 几何

等高线为椭圆，中心 $(mu_X, mu_Y)$。

$rho$ 影响椭圆的旋转，$bold(Sigma)$ 的特征向量 $v_1, v_2$ 为椭圆的长短轴方向，轴长正比于 $sqrt(lambda_1)$, $sqrt(lambda_2)$。对称正定矩阵一定存在两个正特征实根，也一定可以选出一对正交的特征向量。（$lambda_1 = lambda_2$ 时退化为圆）

==== 分解

配方
$ &((x - mu_X)/sigma_X)^2 - 2 rho (x - mu_X)/sigma_X (y - mu_Y)/sigma_Y + ((y - mu_Y)/sigma_Y)^2\
=& ((x - mu_X)/sigma_X - rho (y - mu_Y)/sigma_Y)^2 + (1 - rho^2)((y - mu_Y)/sigma_Y)^2 $

于是
$ f(x, y) = &1/(2 pi sigma_X sigma_Y sqrt(1 - rho^2)) exp(-1/2 ((y - mu_Y)/sigma_Y)^2 - 1/(2(1 - rho^2)) ((x - mu_X)/sigma_X - rho (y - mu_Y)/sigma_Y)^2)\
= &1/(sigma_Y sqrt(2 pi)) exp(-1/2 ((y - mu_Y)/sigma_Y)^2) times\
 &1/(sigma_X sqrt(2 pi) sqrt(1 - rho^2)) exp(-1/(2(1 - rho^2)) ((x - mu_X)/sigma_X - rho (y - mu_Y)/sigma_Y)^2)\
= &1/(sigma_Y sqrt(2 pi)) exp(-1/2 ((y - mu_Y)/sigma_Y)^2) times\
&1/(sigma_X sqrt(2 pi) sqrt(1 - rho^2)) exp(-1/(2(1 - rho^2)) ((x - (mu_X + rho sigma_X/sigma_Y (y - mu_Y)))/sigma_X)^2) $

第一项为 $N(mu_Y, sigma_Y^2)$ 的 p.d.f.，第二项为 $N(mu_X + rho sigma_X/sigma_Y (y - mu_Y), sigma_X^2(1 - rho^2))$ 的 p.d.f.

对称地，若对 $y$ 配方，则第一项为 $N(mu_X, sigma_X^2)$ 的 p.d.f.，第二项为 $N(mu_Y + rho sigma_Y/sigma_X (x - mu_X), sigma_Y^2(1 - rho^2))$ 的 p.d.f.

后面可以看到，这即是 $p(x, y) = p(x) p(y | x) = p(y) p(x | y)$ 的两种表示。

==== 边缘分布

$ f_X (x) = &integral_(-oo)^(oo) f(x, y) dif y\
= &integral_(-oo)^(oo) 1/(sigma_X sqrt(2 pi)) exp(-1/2 ((x - mu_X)/sigma_X)^2) times\
&1/(sigma_Y sqrt(2 pi) sqrt(1 - rho^2)) exp(-1/(2(1 - rho^2)) ((y - mu_Y)/sigma_Y - rho (x - mu_X)/sigma_X)^2) $

换元 $t = 1/sqrt(1 - rho^2)((y - mu_Y)/sigma_Y - rho (x - mu_X)/sigma_X)$，于是 $dif y = sigma_Y sqrt(1 - rho^2) dif t$

$ f_X (x) = & 1/(sigma_X sqrt(2 pi)) exp(-1/2 ((x - mu_X)/sigma_X)^2) times integral_(-oo)^(oo) 1/sqrt(2 pi) exp(-1/2 t^2) dif t\
= & 1/(sigma_X sqrt(2 pi)) exp(-1/2 ((x - mu_X)/sigma_X)^2) $

由此，$X tilde N(mu_X, sigma_X^2)$, $Y tilde N(mu_Y, sigma_Y^2)$。而 $rho$ 在过程中被约去，于是仅知 $f_X, f_Y$ 不能确定 $rho$。

==== $n$ 元情景

记 $bold(Sigma)$ 为 $n$ 阶正定对称矩阵，则定义 $n$ 元正态分布 $N(bold(mu), bold(Sigma))$
$ p(bold(x)) = 1/((2 pi)^(n/2) sqrt(det bold(Sigma))) exp(-1/2 (bold(x - mu))bold(Sigma)^(-1)(bold(x - mu))^T) $
$n = 2$ 时 $bold(mu) = (mu_X, mu_Y)^T, sp bold(sigma) = mat(sigma_X^2, rho sigma_X sigma_Y; rho sigma_X sigma_Y, sigma_Y^2)$

== 独立性

取 $upra = {x_1 < X leq x_2}$, $uprb = {y_1 < Y leq y_2}$。二者独立则 $P(upra uprb) = P(upra) P(uprb)$。特别地，取 $(-oo, x), (-oo, y)$，则 $P{X leq x, Y leq y} = P{X leq x} P{Y leq y}$，也即
$ F(x, y) = F_X (x) F_Y (y) $

此时
$ &P{x_1 < X leq x_2, y_1 < Y leq y_2}\
= &F(x_2, y_2) - F(x_1, y_2) - F(x_2, y_1) + F(x_1, y_1) quad "(property of d.f.)"\
= &F_X (x_2) F_Y (y_2) - F_X (x_1) F_Y (y_2) - F_X (x_2) F_Y (y_1) + F_X (x_1) F_Y (y_1) quad "(independence)"\
= &(F_X (x_2) - F_X (x_1)) times (F_Y (y_2) - F_Y (y_1))\
= &P{x_1 < X leq x_2} times P{y_1 < Y leq y_2} $

于是 $F(x, y) = F_X (x) F_Y (Y)$ 是独立性的充要条件。

一般地，若 $F(x_1, dots.c, x_n) = product F_(X_i) (x_i)$，称 ${X_n}$ 相互独立。此时 $g_i (X_i)$ 也相互独立（${g_n}$ 为任意一列连续函数）。

#divider()

- #[
    离散型：$p_(i, j) = p_i p_j$
]
- #[
    连续型：$f(x, y) = f_X (x) f_Y (y)$

    合理猜测：$p arrow.l.r f dif quad imply quad p_(i, j) = p_i p_j arrow.l.r f dif x dif y = f_X dif x f_Y dif y$    

    充分性：$F(x, y) = integral integral f(u, v) = integral f(u) integral f(v) = F_X (x) F_Y (y)$\
    必要性：$f(x, y) = (partial^2 F)/(partial x partial y) = (partial^2 F_X F_Y)/(partial x partial y) = (dif f(x) F_Y)/(dif y) = f_X (x) f_Y (y)$

]

#divider()

#example()[
    正态分布 $X, Y$ 相互独立

    $f(x, y) = f_X (x) f_Y (y) sp iff sp rho = 0$
]



== 条件分布

==== 离散型

$P{X = x_i | Y = y_j} = p_(i, j)/p_(dot, j)$

==== 连续型

$P{X leq x | Y = y} = P{X leq x, Y = y}/P{Y = y}$ 为 0/0 型极限。为此，把 $Y = y$ 拓宽为 $abs(Y - y) < epsilon$，改为 $epsilon to 0^+$ 时的极限。（不用 $X = x$ 是因为取到单点的概率为 0）

$ &P{X leq x | Y = y}\
= &lim_(epsilon to 0^+) P{X leq x | abs(Y - y) < epsilon}
= lim_(epsilon to 0^+) P{X leq x, |Y - y| < epsilon}/P{|Y - y| < epsilon}\
= &lim_(epsilon to 0^+) (F(x, Y + epsilon) - F(x, Y - epsilon))/(F_Y (Y + epsilon) - F_Y (Y - epsilon))\
= &(partial F(x, y))/(partial y) sp slash sp ((dif F_Y (y))/(dif y)) quad ("div" 2 epsilon "on both")\
= &integral_(-oo)^x f(t, y)/(f_Y (y)) dif t $

需额外限制 $f_Y (y) > 0$ 且 $f, f_Y$ 均在 $(x, y)$ 连续。（若不成立，则无法定义条件概率。特别地，$f_Y (y) = 0$ 处均不在 $f_(X | Y)$ 定义域内。*需要声明定义域*。）

在 $Y = y$ 条件下 $X$ 的条件概率密度
$ f_(X | Y)(x | y) = f(x, y)/(f_Y (y)) $

#divider()

#example()[
    正态分布 $(x, y) tilde N(mu_1, mu_2, sigma_1, sigma_2, rho)$，求 $f_(Y | X) (y | x)$

    由分解及边缘分布即得，服从 $N(mu_2 + rho sigma_2/sigma_1 (x - mu_1), sigma_2^2 (1 - rho^2))$
]

== 函数分布

$X: Omega to RR^n$, $g: RR^n to RR^m$, $g(X): Omega to RR^m$

证明：$X_i tilde N(mu_i, sigma_i^2)$ 且相互独立，则 $X = sum X_i tilde N(sum mu_i, sum sigma_i^2)$；本质？

=== 例子

- #[
    $Z = X + Y$

    $ F_Z (z) &= P{X + Y leq z} = integral_(-oo)^(oo) dif x integral_(-oo)^(z - x) f(x, y) dif y\
    &= integral_(-oo)^z dif u integral_(-oo)^(+oo) f(x, u - x) dif x quad ("let" u = x + y)\
    imply f_Z (z) &= (dif F_Z (z))/(dif z) = integral_(-oo)^(+oo) f(x, z - x) dif x $

    若 $X, Y$ 相互独立，则 $f(x, z - x) = f_X (x) f_Y (z - x)$，于是
    $ f_Z (z) = integral_(-oo)^(oo) f_X (x) f_Y (z - x) $
    也即 $f_X$ 和 $f_Y$ 的卷积 $f_X ast f_Y$
]

- #[
    $Z = max{X_n}$

    $ F_Z (z) = P{max{X_n} leq z} = integral_(forall x_i leq z) f(x_1, dots.c, x_n) dif x_1 dots.c dif x_n $

    若 ${X_n}$ 相互独立，则
    $ F_Z (z) = P{max{X_n} leq z} = product P{X_i leq z} = product F_(X_i) (z) $
]
- #[
    $Z = min{X_n}$

    $ F_Z (z) &= P{min{X_n} leq z}\
    1 - F_Z (z) &= P{min{X_n} > z} = integral_(forall x_i > z) f(x_1, dots.c, x_n) dif x_1 dots.c dif x_n $

    若 ${X_n}$ 相互独立，则
    $ F_Z (z) &= 1 - P{min{X_n} > z} = 1 - product P{X_i > z}\
    &= 1 - product (1 - F_(X_i) (z)) $
]

=== 换元

已知随机向量 $bold(X) = (X_1, dots.c, X_n)$ 的分布 $f_(bold(X)) (bold(x))$。又有可逆映射 $phi: RR^n to RR^n$，映 $bold(Y) = (Y_1 (X_1, dots.c, X_n), dots.c, Y_n (X_1, dots.c, X_n))$，希望求 $f_Y (bold(y))$

具体地，要求 Jacobi 行列式 $J = (partial(x_1, dots.c, x_n))/(partial(y_1, dots.c, y_n))$ 处处不为零。其中 $x_i = x_i (y_1, dots.c, y_n)$ 为逆映射。于是有
$ &integral_(Omega) f_(bold(X)) (bold(x)) dif bold(x) = 1\
imply &integral_(phi^(-1)(Omega)) f_(bold(X)) (bold(x)(bold(y))) sp abs(J) sp dif bold(y) = 1 $

而 $integral f_(bold(Y)) (bold(y)) dif bold(Y) = 1$，对比两式即得
$ f_(bold(Y)) (bold(y)) = abs(J) f_(bold(X)) (bold(x)) quad "where" phi(bold(x)) = bold(y) $

求 $J$ 不必显式求出逆映射，求全微分。

= 数字特征

== 期望

=== 定义

=== 性质

- #[
    线性性
]

- #[
    若 $X,Y$ 相互独立，则 $E(X Y) = E(X) E(Y)$
]

=== 离散型

d.l. $P{X = x_i} = p_i$，若级数 $sum x_i p_i$ 绝对收敛，则定义
$ E(X) := sum x_i p_i $

- #[
    0-1 分布：$E(X) = p$
]
- #[
    $X tilde b(n, p)$：$E(X) = n p$
]
- #[
    $X tilde pi(lambda)$：$E(X) = lambda$
]

#example()[
    若 $X geq 1$（严谨地，这是说 $P{X < 1} = 0$），则 $E(X) = sum_k P{X geq k}$

    证明是平凡地交换求和符，绝对收敛保证交换律和结合律。
]

=== 连续型

$ E(X) := integral_(-oo)^(oo) x f(x) dif x $

- #[
    $X tilde U(a, b)$：$E(X) = (a + b)/2$
]
- #[
    $X tilde N(mu, sigma^2)$：$E(X) = mu$
]
- #[
    指数分布：$E(X) = 1/lambda$
]

#example()[
    柯西分布 $E(X)$ 不存在

    $ f(x) = 1/pi 1/(1 + x^2) $
]

== 方差

=== 定义

$ D(X) := E((X - E(X))^2) $

Var$(X)$，$sigma(X) = sqrt(D(X))$

=== 性质

- #[
    $D(X) = E(X^2) - [E(X)]^2$

    $D(X) = E[(X - E X)^2] = E(X^2 - 2 X E(X) + (E(X))^2) = E(X^2) - 2 E(X) E(X) + (E(X))^2 = E(X^2) - [E(X)]^2$
]

#divider()

- #[
    $D(C) = 0$
]

- #[
    $D(a X) = a^2 D(X)$

    $D(a X) = E[(a X - E(a X))^2] = a^2 E[(X - E X)^2] = a^2 D(X)$
]

于是 $D(a X + b) = a^2 D(X)$

#divider()

$ D(a X + b Y) &= E[ (a X + b Y - E(a X + b Y))^2 ]\
&= E[ (a(X - E X) + b(Y - E Y))^2 ]\
&= a^2 D(x) + b^2 D(y) + 2 a b E(X - E X)(Y - E Y)\
&= vec(a, b)^T mat(D(X), cov(X, Y); cov(X, Y), D(Y)) vec(a, b) $

- #[
    若 $X, Y$ 相互独立，则 $D(X plus.minus Y) = D(X) + D(Y)$

    进一步，若 ${X_n}$ 相互独立，则 $D(sum X_i) = sum D(X_i)$
]

=== 例子

- #[
    $(0-1)$ 分布

    $E(X^2) = E(X) = p sp imply sp D(X) = p - p^2 = p(1 - p)$
]

- #[
    $b(n, p)$

    $n$ 次独立的伯努利试验，由性质 $D(X) = n D(X_1) = n p (1 - p)$
]
- #[
    $pi(lambda)$
]

#divider()

- #[
    $U(a, b)$
]

- #[
    $N(mu, sigma)$
]

== 协方差

令 $g(x, y) = (x - E X)(y - E Y)$，则 $cov(X, Y) = E(g(X, Y))$

记全体一维随机变量构成空间 $V$，在 $V$ 上定义了加法 $X + Y$ 和标量乘法 $k X, k in RR$，进而启发把 $V$ 视为线性空间。

Cov 是 $V$ 上的一个内积，继而相关系数是向量夹角。
#proof()[
    $cov(X, Y) := E[(X - E X)(Y - E Y)]$

    - #[
        $cov(X, X) = E[(X - E X)^2] = D(X) geq 0$

        但 $cov(X, X) = 0$ 的 $X$ 不唯一，于是 $V$ 不是真正的线性空间，不过无影响。
    ]
]