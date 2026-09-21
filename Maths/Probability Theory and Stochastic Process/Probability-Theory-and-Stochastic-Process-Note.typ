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

/* specific math abbr. */
#let opp(x) = math.overline(x)

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
            #text(size: 初号)[Contents]
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

= Definitions

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
        $ P(union.big_(i = 0)^oo A_i) = sum_(i = 0)^oo P(A_i) $
    ]
]
则称 $P$ 为定义在 $(Omega, cal(F))$ 上的概率，概率空间 $(Omega, cal(F), P)$

性质：
- #[
    $P(emptyset) = 0$
]