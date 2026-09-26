/* 中文伪粗体 */
#import "@preview/cuti:0.4.0": show-cn-fakebold
#show: show-cn-fakebold

/* 画图 */
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

/* a more friendly templete for numbering */
#import "@preview/numbly:0.1.0": numbly

/* text sizes */
#let 初号 = 42pt
#let 小初 = 36pt
#let 一号 = 28pt
#let 小一 = 24pt
#let 二号 = 21pt
#let 小二 = 18pt
#let 三号 = 16pt
#let 小三 = 15pt
#let 四号 = 14pt
#let 小四 = 12pt
#let 五号 = 10.5pt
#let 小五 = 9pt

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

/* spacing */
// em is the size of cur font, about the width of one Chinese character
#let en = sym.space.en // 1/2 em, about one letter in monospaced font e.g. console
#let sp = sym.space
// space: 1/4 em, equal to a normal "space" when enter a "space"

// wide : 2    em, ~ \qquad 
// quad : 1    em, ~ \quad
// thick: 5/18 em, ~ \;
// med  : 2/9  em, ~ \:
// thin : 1/6  em, ~ \,

/* general math abbr. */
#let iff = math.arrow.l.r.double
#let imply = math.arrow.r.double
#let to = math.arrow.r
#let get = math.arrow.l

#let leq = math.lt.slant
#let geq = math.gt.slant

#let proof-style = [证明：]
#let proof(body) = block( // using grid to create auto left hanging
    grid(
        columns: (auto, 1fr),
        gutter: 0.5em,
        proof-style,
        body,
    ),
)

/* specific math abbr. */
#let opp(x) = math.overline(x)
#let upr(x) = math.upright(x)
#let eve(x, y) = $upright(#x)_(#y)$

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

= 定义

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

    证明：a. 单调有界有极限。取 $B_1 = A_1, B_i = A_i - A_(i - 1)$，则 $A = union.big B_i$。\
    b. 
]

== 条件概率

=== 定义

给定 $(Omega, cal(F), P)$，设事件 $B$ 满足 $P(B) > 0$，定义映射
$ P(ast | B): cal(F) arrow.hook RR\
P(A | B) arrow.bar P(A B)/P(B) $
依次验证 $P(ast | B)$ 满足公理化的 3 个条件，故其确为概率，称条件概率。继而概率的 6 条性质可以迁移到条件概率。

=== 公式

==== 乘法公式

$P(B) > 0$ 时，$P(A B) = P(A) times P(A | B) = P(B) times P(B | A)$

推广：若 $P(A_1 dots.c A_(n - 1)) > 0$，则
$ P(A_1 dots.c A_n) = P(A_1) times P(A_2 | A_1) times P(A_3 | A_1 A_2) times dots.c times P(A_n | A_1 dots.c A_(n - 1)) $

==== 全概率公式

一个 $SS$ 的划分 ${B_n}$ 是满足如下条件的一列事件：\
a. $B_i B_j = emptyset$ \
b. $union.big B_i = SS$

取一列划分 ${B_n}$，则：
$ P(A) = sum P(A | B_i) P(B_i) $
#proof()[
    $A = A SS = A (union B_i) = union (A B_i)$，而 $(A B_i) inter (A B_j) = emptyset$。由可列可加性展开，再基于乘法公式。
]

推论：$min{P(A | B_i)} leq P(A) leq max{P(A | B_i)}$

==== 贝叶斯公式

- #[
    两枚硬币：一枚正反一样，一枚正常。等概率随机取一枚，在连抛两次都是正面的条件下，第三次是正面的概率？

    记事件 $eve(A, i)$ 为第 $i$ 次为正面，$upr(F)$ 为使用正常硬币。已知 $P(eve(A, ast) | upr(F)) = 1/2 en P(eve(A, ast) | opp(upr(F))) = 1$

    在第一次实验前：$P(upr(F)) = 1/2 en P(opp(upr(F))) = 1/2$

    在第一次实验后 a.k.a. 第二次实验前：
    $ P(upr(F) | eve(A, 1)) &= P(upr(F)eve(A, 1))/P(eve(A, 1))
    = (P(eve(A, 1) | upr(F)) P(upr(F)))/(P(eve(A, 1) | upr(F)) P(upr(F)) sp + sp P(eve(A, 1) | upr(opp(F))) P(opp(upr(F)))) \
    &= (1/2 times 1/2)/(1/2 times 1/2 + 1 times 1/2) = 1/3 $

    第二次实验后，将其视为在第一次基础上的实验，第一次的后验概率变为第二次的先验概率：（形式上，所有推演套在 $P(ast | eve(A, 1))$ 中。亦可看作 $P(upr(F) eve(A, 1) eve(A, 2))  slash P(eve(A, 1) eve(A, 2))$ 上下同除 $P(eve(A, 1))$。）
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

=== 定义

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