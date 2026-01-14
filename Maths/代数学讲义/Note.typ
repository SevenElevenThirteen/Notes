/*
  中文伪粗体
*/
#import "@preview/cuti:0.3.0": show-cn-fakebold
#show: show-cn-fakebold

/*
  画图
  大小：5mm, 5mm
*/
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge

/*
  字体设置
  Times New Roman 不支持中文
  默认小五号 9pt
*/
#set text(
  font: ("Times New Roman", "NSimSun"),
  size: 9pt
)

/*
  大小
*/
#let 一号(_text) = [
  #set text(size: 28pt)
  #(_text)
]
#let 小一号(_text) = [
  #set text(size: 24pt)
  #(_text)
]
#let 二号(_text) = [
  #set text(size: 21pt)
  #(_text)
]
#let 小二号(_text) = [
  #set text(size: 18pt)
  #(_text)
]
#let 三号(_text) = [
  #set text(size: 16pt)
  #(_text)
]
#let 小三号(_text) = [
  #set text(size: 15pt)
  #(_text)
]
#let 四号(_text) = [
  #set text(size: 14pt)
  #(_text)
]
#let 小四号(_text) = [
  #set text(size: 12pt)
  #(_text)
]
#let 五号(_text) = [
  #set text(size: 10.5pt)
  #(_text)
]
#let 小五号(_text) = [
  #set text(size: 9pt)
  #(_text)
]
#let 六号(_text) = [
  #set text(size: 8pt)
  #(_text)
]
#let 小六号(_text) = [
  #set text(size: 6.875pt)
  #(_text)
]
#let 七号(_text) = [
  #set text(size: 5.25pt)
  #(_text)
]
#let 八号(_text) = [
  #set text(size: 4.5pt)
  #(_text)
]

/*
  其它
*/
#let dotc = math.dots.h.c//居中省略号

#let divider = line(length: 100%)//分割线
#let newpage = pagebreak(weak: true)

#let leq = math.lt.eq.slant
#let geq = math.gt.eq.slant

#let mathbf(_text) = math.bold(math.upright(_text))//正体粗体
#let mathrm(_text) = math.upright(_text)//正体

#let tab = [$quad$]

#let implies = math.arrow.r.double
#let iff = math.arrow.l.r.double

#let gets = math.arrow.l
#let to = math.arrow.r

#let sim = math.tilde.op

#let lcm = mathrm("lcm")

#let inf = math.infinity

/*
  目录一号
  章标题二号
  节标题三号
*/

#一号[
  #outline( depth: 2 )<outline>
]
#newpage

= #二号[1. 综述]

== #三号[1.1 \~ 1.2]
*Theorem 1.1.1*（代数基本定理）\
$f(x) = limits(sum)_(i = 1)^n$，则 $exists x_1 dots x_n in bb(C), space s.t. space f(x) = limits(product)(x - x_i)$\
\

== #三号[1.3 线性方程组与 Gauss-Jordan 消元]
考虑方程组
$ cases(
  &a_11x_1 + a_12x_2 + dotc + a_(1n) = &b_1,
  &a_21x_1 + a_22x_2 + dotc + a_(2n) = &b_2,
  &dots.v &dots.v,
  &a_(n 1)x_1 + a_(n 2)x_2 + dotc + a_(n n) = &b_n
) $

*Definition 1.3.3*\
增广矩阵
$mat(
  &a_11, a_12, dotc, a_(1n), &b_1;
  &a_21, a_22, dotc, a_(2n), &b_2;
  &dots.v, , , , &dots.v;
  &a_(n 1), a_(n 2), dotc, a_(n n), &b_n;
)$
或写作
$mat(
  &a_11, a_12, dotc, a_(1n), &b_1;
  &a_21, a_22, dotc, a_(2n), &b_2;
  &dots.v, , , , &dots.v;
  &a_(n 1), a_(n 2), dotc, a_(n n), &b_n;
  augment: #4
)$\
\
系数矩阵
$mat(
  &a_11, a_12, dotc, &a_(1n);
  &a_21, a_22, dotc, &a_(2n);
  &dots.v, , , &dots.v;
  &a_(n 1), a_(n 2), dotc, &a_(n n);
)$\
零矩阵 $forall a_(i,j) = 0$
#divider

*Gauss-Jordan 消元*\
三种初等行变换：\
$&A(u, v, k): forall a_(v, t) arrow.l a_(v, t) + k times a_(u, t)\
&B(u, v): forall "swap" (a_(u, t), a_(v, t))\
&C(u, k): forall a_(u, t) arrow.l a_(u, t) times k$\
每种操作可逆，同解\
\
*Definition 1.3.4 行梯矩阵*\
形如上三角矩阵，每行以非零元开头。非零元称为主元。\
每多一个主元，占去一行，阶梯缩进一列，故主元个数 $r leq min(n, m)$\
\
*Definition 1.3.6 简化行梯矩阵*\
进一步地，所有主元为 1，该列其它数均为 0\
\
消元，略。$Theta(n^3)$\
最终，若非无解，则一定是前 $r$ 行对应前 $r$ 个主元。
#divider
\

== #三号[1.4 总结]
1. 若简化行梯矩阵包含形如 $mat(0, dotc, 0, 1; augment: #3)$ 的行，则无解
2. 在简化行梯矩阵中，记主元依次在第 $p_1 < dotc < p_r$ 列，称为主列。对 $p_k$，有
   $ x_(p_k) + limits(sum)_(t > p_k \ "非主元") a_(k, t) x_t = b_k $
   则可以唯一解出 $x_(p_k)$。而对于非主列，这些未知数为自由变元
3. 因此，$n$ 元线性方程组，要么无解，要么解集依赖于 $n - r$ 个自由变化的参数（即，自由度），其中 $r$ 是主元个数\
\

== #三号[Exercise]
1. 证明无论如何消元，得到的简化行梯矩阵均相同。\
   
   记 $mathbf(A) = 
   mat(&a_(1, 1), &dotc, &a_(1, n);
   &quad dots.v, &dotc, &quad dots.v;
   &a_(n, 1), &dotc, &a_(n, n);)$，
   $mathbf(B) = mat(&b_(1, 1), &dotc, &b_(1, n);
   &quad dots.v, &dotc, &quad dots.v;
   &b_(n, 1), &dotc, &b_(n, n);)$\
   称 $mathbf(A)$ 与 $mathbf(B)$ 行等价，如果可以通过初等行变换从一个变为另一个。\
   证明分三步，即三小问。\
   
   $mathrm(i.))$ 若行等价，则同时删除任意 $1 leq c_1 < dotc < c_k leq n$ 列，仍行等价。\
   _proof._ 显然。\
   
   $mathrm(i i.))$ 若 $mathbf(A), mathbf(B)$ 形如（空白均为 $0$）：\
   $ mathbf(A) = mat(&1, &quad, &quad, &quad, &x_1;
                    &quad, &1, &quad, &quad, &x_2;
                    &quad, &quad, &dots.v, &quad, &dots.v;
                    &quad, &quad, &quad, &1, &x_r;
                    &quad, &quad, &quad, &quad, &quad;
                    &quad, &quad, &quad, &quad, &quad;) quad
    mathbf(B) = mat(&1, &quad, &quad, &quad, &y_1;
                    &quad, &1, &quad, &quad, &y_2;
                    &quad, &quad, &dots.v, &quad, &dots.v;
                    &quad, &quad, &quad, &1, &y_r;
                    &quad, &quad, &quad, &quad, &quad;
                    &quad, &quad, &quad, &quad, &quad;) $
  则 $forall t = 1, dotc, r quad x_t = y_t$\
  _proof._ 矩阵视为线性方程组。因为二者行等价，则方程组同解，即证。\
  
  $mathrm(i i i.))$ 一般情形的证明：若行等价，则 $mathbf(A) = mathbf(B)$\
  _proof._ 消元。主元所在列必相同。取这 $r$ 列和任意非主列构成 $r + 1$ 列子矩阵，变为 $mathrm(i i.)$，以此类推全相同。\
\

#newpage

= #二号[2. 集合，映射与关系]

== #三号[2.0 基础知识]
考虑 $f: A to B$\
$f(a) = b$，$b$ 为 $a$ 的像，$a$ 为 $b$ 的原像\
${b in B: exists a in A, b = f(a)}$，$f$ 的像集，记为 $mathrm(im)(f)$

*单射*：$forall u != v, f(u) != f(v)$\
*满射*：$forall b in B, exists a in A, f(a) = b$\
*双射 / 一一映射*：既单又满

== #三号[2.1 ZFC 基础]
*外延公理*：$forall space A, B quad A = B iff (A subset B) and (B subset A)$

*配对公理*：$forall a, b$，存在集合 ${a, b}$ 使其元素恰为 $a, b$\
#tab 由外延公理可知这样的集合唯一。特别地，$a = b$ 时，定义了单点集 ${a}$。\
#tab 有序对定义： $(a, b) = {{a}, {a, b}}$

*分离公理模式*：$forall A, space cal(P)$，存在 ${a in A | cal(P)(a)}$\
#tab 模式：对每个 $cal(P)$，产生一则公理\
#tab 要求 $a in A$，为了避免理发师悖论

*并集公理*：存在集合 $union.big A = { x | exists a subset A, x in a }$\
#tab 定义 $X union Y = union.big {X, Y}$\
#tab 定义 ${x, y, dotc, z} = {x} union {y, dotc, z}$

*幂集公理*：$A$ 的所有子集的集合，称为*幂集*。记作 $P(A) = { B | B subset A }$ 或 $2^A$

*无穷公理*：存在无穷集

*替换公理模式*：$cal(F)$ 为定义在 $A$ 上的函数，存在集合 $cal(F)(A)$，有 $forall b in cal(F)(A) iff exists a in A, b = cal(F)(a) $

*Definition 2.1.2* *Cartesius 积*（笛卡尔）或 *积*\
#tab $A times B = {(a, b) | a in A, b in B}$\
#tab 同理，$A times B times C times dotc = {(a, b, c, dotc) | a in A, dotc}$\
#tab $A^n = underbrace(A times dotc times A, "n 个")$\

空集 $emptyset = {a in A | a eq.not a}$，其中 $A$ 为任意集合

交、并略

*正则公理*：$forall A eq.not emptyset, exists a in A, space a inter A = emptyset$\
e.g. 定义 $0 = emptyset, 1 = {0}, n = {0, 1, dotc, n - 1}$，考虑 $A = {1, 2, 3} = {0, {0, 1}, {0, 1, 2}}$，有 ${0} union A = emptyset$

*选择公理*：$forall a in A, a eq.not emptyset$，则存在函数 $g: A arrow.r union.big A space s.t. space forall a in A, space g(a) in a$\
#tab 可以从每个集合中选一个

Zermelo–Fraenkel 公理集合论。加入选择公理，ZFC。

== #三号[2.2 映射]
*Definition 2.2.1*\
$A, B$ 集合，$f: A to B$ 或 $A to^f B$。\
将 $f: A to B$ 理解为 $A times B$ 的子集 $Gamma_(f)$，满足
 $forall a in A, {b in B: (a, b) in Gamma_f}$ 是独点集，唯一元素 $f(a)$，称 $a$ 在 $f$ 下的像\
$Gamma_f$ 称 $f$ 的*图形*\
*恒等映射*：$mathrm(id)_A: A to A$

$g compose f = g f = g(f())$\
任意 $f: A to B$，有 $f compose mathrm(id)_A = f = mathrm(id)_B compose f$

*Definition 2.2.3* $A arrows.rl^f_g B$，若 $g f = mathrm(id)_A$，称 $g$ 是 $f$ 的*左逆*，$f$ 是 $g$ 的*右逆*\
从矩阵角度，即 $mathbf(G) times mathbf(F) times v = v$

*Definition 2.2.5* 考虑 $f: A to B$\
- $forall C, g_1, g_2: C to A$ 有 $f g_1 = f g_2 implies g_1 = g_2$\
  称 $f$ 对映射合成有左消去律

- $forall C, g_1, g_2: B to C$ 有 $g_1 f = g_2 f implies g_1 = g_2$\
  称 $f$ 有右消去律

若 $f$ 有左逆，则有左消去律，因为\
$f g_1 = f g_2 implies h f g_1 = h f g_2 iff g_1 = g_2$

若 $f$ 有右逆，则有右消去律

*Proposition 2.2.6* $f: A to B$ 且 $A != emptyset$，则以下性质等价：\
- $f$ 是单射 $iff$ $f$ 有左逆 $iff$ $f$ 有左消去律
- $f$ 是满射 $iff$ $f$ 有右逆 $iff$ $f$ 有右消去律

proof.
- $1 to 2$ 显然\
  $2 to 3$ 上文已证\
  $3 to 1$ $forall f(a_1) = f(a_2)$，构造 $g_(1,2): {0} to A, g_i (0) = a_i$。$f g_1 = f g_2 implies g_1 = g_2 implies a_1 = a_2$\
- $1 to 2$ 显然\
  $2 to 3$ 上文已证\
  $3 to 1$ 构造 $g_(1,2): B to {0, 1}$,
          $g_1(b) = 0, g_2(b) = cases(0 space b in mathrm(im)(f), 1 space b in.not mathrm(im)(f))$。
          有 $g_1 f = g_2 f implies g_1 = g_2 implies B = mathrm(im)(f)$

*Definition 2.2.7*\
若 $f$ 左右均可逆，称*可逆*映射。此时有唯一 $f^(-1)$ 使 $f^(-1) compose f = mathrm(id)_A$ 且 $f compose f^(-1) = mathrm(id)_B$\
进一步地，$f$ 可逆的充要条件是 $exists f^(-1), f^(-1) compose f = mathrm(id)_A, f compose f^(-1) = mathrm(id)_B$

proof. 设 $g_L, g_R$ 为左右逆，$g_L = g_L compose mathrm(id)_B = g_L compose f compose g_R = mathrm(id)_A compose g_R = g_R$\
左右逆分别唯一也易证。故左右逆相同且唯一

*Proposition 2.2.8*\
- 若 $f$ 可逆，则 $f^(-1)$ 可逆，且 $(f^(-1))^(-1) = f$
- 若 $f: A to B, g: B to C$ 均可逆，则 $g f: A to C$ 可逆，且 $(g f)^(-1) = f^(-1) g^(-1)$

proof. 代入检验均可得证

*Proposition 2.2.9* $f$ 是双射 $iff$ $f$ 可逆，逆映射即上文 $f^(-1)$\
注：前文说明了，$f$ 单且满

Exercise 2.2.12\
$f: A to B$，$A_i, B_i$ 为一族子集，有\
$ f^(-1)(union.big B_i) = union.big f^(-1)(B_i), space f^(-1)(inter.big B_i) = inter.big f^(-1)(B_i) $
$ f(union.big A_i) = union.big f(A_i), space f(inter.big A_i) subset inter.big f(A_i) $
*注意*：最后一个是 $subset$ 不是 $=$

== #三号[2.3 集合的积与无交并]
一列集合：$A_1, A_2, dotc, A_n$，积 $product_(i = 1)^n A_i$，
        元素 $(a_i)_i$，第 $i$ 分量 $a_i$

一族集合：$(A_i)_(i in I)$，定义 $limits(product)_(i in I) A_i = {f: I to limits(union.big)_(i in I) A_i | forall i in I, f(i) in A_i}$，
        元素 $(a_i)_(i in I) in limits(product)_(i in I) A_i$，第 $i$ 个投影映射 $p_i: limits(product)_(j in I) A_j to A_i$\
注： 相当于前文 $(a_1, dotc, a_n)$ 对应 $(f(1), dotc, f(n))$，前文是元组的集合，后文是映射的集合
\

特例：所有 $A_i$ 均相同，记为 $A^I = {f: I to A}$\
当 $I = emptyset$ 时，规定 $A^I = {emptyset}$；$A^0 = A^emptyset = {emptyset}$

#divider
设 $A = limits(union.big)_(i in I) A_i$，且 $forall i, j in I, i != j implies A_i inter A_j = emptyset$\
称 $A$ 为 $(A_i)_(i in I)$ 的*无交并*，$(A_i)_(i in I)$ 是 $A$ 的一个*划分*，记作 $A = limits(union.sq.big)_(i in I) A_i$
\

任意 $(A_i)_(i in I)$，构造 $limits(union.sq.big)_(i in I) A_i = {(a, i) in (limits(union.big)_(i in I) A_i) times I | a in A_i}$\
注：这里相当于简单地将所有集合并为一个可重集，未去重。实现上，给每个元素一个标签以区分。\
对每个 $i in I$，有单射 $ iota_i: &A_i arrow.r.hook limits(union.sq.big)_(j in I) A_j \ &a arrow.r.bar (a, i) $ 称第 $i$ 个*嵌入映射*，
无交并即为 $mathrm(im)(iota_i)$ 的并，且 $mathrm(im)(iota_i)$ 两两不交
\

对有限个集合 $A_1, dotc A_n$，无交并记为 $A_1 union.sq dotc union.sq A_n$

当 $I = emptyset$ 时，规定无交并为 $emptyset$
\

注：无交并其它定义，比如映射到 $(a, i, i)$？如果 $exists iota_i, iota_i^'$ 使得 $iota_i: A_i to A, iota_i^': A_i to A^'$，
则存在唯一双射 $phi: A to A^'$。因此，这些定义是等价的。

#divider

交换图表：有向图，点表集合，边表映射

== #三号[2.4 序结构]
*Definition 2.4.1* 二元关系\
$R subset A times B$，$a R b, a in A, b in B$ 表示 $(a, b) in R$\
特别地，$A = B$，是 $A$ 上的二元关系
\

*对角子集*：$Delta_A = {(a, a)}$
\

*Definition 2.4.2* 设 $prec.eq$ 是 $A$ 的二元关系，满足以下性质时，
称 $prec.eq$ 是 $A$ 上的*预序*，$(A, prec.eq)$ 为*预序集*\
- *反身性*：$forall a in A, a prec.eq a$
- *传递性*：$forall a, b, c in A, a prec.eq b, b prec.eq c implies a prec.eq c$

进一步地，如果还满足反称性，称 $prec.eq$ 为*偏序*，$(A, prec.eq)$ *偏序集*
- *反称性*：$forall a, b in A, a prec.eq b, b prec.eq a implies a = b$

对*偏序集* $(A, prec.eq)$，若 $forall a, b$ $a prec.eq b$ 或 $b prec.eq a$ 成立，
即任意两个元素可比大小，称*全序集*或*链*
\

习惯以 $a prec b$ 表示 $a prec.eq b$ 且 $a != b$，以 $A$ 代指 $(A, prec.eq)$
\

如果 $(A, prec.eq)$ 是某种集，则 $forall A' subset A$ 也是某种集
\

例子：
- $(ZZ, leq)$：全序集
- $ZZ_(geq 1)$，整除关系：偏序集，非全序集（$x | y and y | x implies x = y$）
- $ZZ \\ {0}$，整除关系：预序集，非偏序集（$x | y implies x = plus.minus y$）
\

*Definition 2.4.3* $f: A to B$ 为预序集间的映射。\
如果 $a prec.eq a' implies f(a) prec.eq f(a')$，称 $f$ 是*保序*的。\
如果 $a prec.eq a' iff f(a) prec.eq f(a')$，称 $f$ 是*严格保序*的
\

Hasse 图
\

*Definition 2.4.4*\
*极大元*，*极小元*\
$A'$ 在 $A$ 中的*上界*，*下界*，其中 $A' subset A$
\

*Definition 2.4.5* 全序集 $forall S subset (A, prec.eq), S != emptyset$，$S$ 都有极小元，
称 $A$ 为*良序集*\
e.g. $NN$
\

$f: A to B$ 是预序集间严格保序双射，称 $f$ 为序结构间的同构。\
预序集 $A, B$ 同构，则任何用序结构表达的性质对二者等价
\

Exercise 2.4.9\
上、下确界 $mathrm(s u p \, i n f)$
\

== #三号[2.5 等价关系与商集]
*Definition 2.5.1* *等价关系*\
- *反身性*：$forall a in A, a sim a$
- *对称性*：$forall a, b in A, a sim b iff b sim a$
- *传递性*：$forall a, b, c in A, a sim b, b sim c implies a sim c$

*Definition 2.5.2* *等价类*\
$C subset A$，且有：
- $C$ 中元素相互等价，$forall a, b in C, a sim b$
- $C$ 对 $sim$ 封闭，$forall a in C, b in A, a sim b implies b in C$

*代表元*：任意 $a in C$，其中 $C$ 为等价类

*Proposition 2.5.3*\
$A$ 是所有等价类的无交并

*Definition 2.5.4*\
*商集*：等价类的集合，$A\/sim space = space {C subset A | C 是 等 价 类}$\
*商映射*：把元素对应所属等价类 $q: A to A\/sim$，必为满射
\

*Proposition 2.5.5*\
设商映射 $q: A to A\/sim$。设 $f: A to B$ 满足 $a sim a' implies f(a) = f(a')$，
则存在唯一 $overline(f): (A\/sim) to B$ 使 $overline(f) compose q = f$\
proof. 至多一个 & 存在，略
\

*Proposition 2.5.8*\
对任意 $f: A to B$，定义 $attach(sim, br: f)$ 使得 $a sim a' iff f(a) = f(a')$，
则 Proposition 2.5.5 给出*双射* $overline(f): (A\/attach(sim, br: f)) to mathrm(im)_f$\
注：尽管像集外在于 $A$，但可以通过等价关系内在地构造
\

== #三号[2.6 $NN$ 与 $QQ$]
构造 $NN$： $ 0 &= emptyset \ 1 &= {emptyset} \ n + 1 &= {0, 1, dotc, n} $\
$NN$ 具有加法、乘法的所有运算律，证明略
#divider

构造 $ZZ$

已有 $NN$，考虑把任意 $x$ 表示为 $x = m - n, space m,n in NN$。\
但现在没有减法的定义，考虑用数对 $(m, n)$ 表示，$(m, n) in NN times NN$\
$x$ 的表示方法不唯一，利用等价类!

$forall (m, n), (m', n')$，有 $m - n = m' - n' iff m + n' = m' + n$\
故在 $NN^2$ 上定义二元关系
$ sim: space (m, n) sim (m', n') iff m + n' = m' + n $
反身性和对称性是显然的，传递性：$forall (a, b) sim (c, d) sim (e, f)$
$ cases(a + d = b + c space (mathrm(i)), c + f = d + e space (mathrm(i i)))
implies^(mathrm(i + i i)) a + f = b + e $
记 $(m, n)$ 所属等价类为 $bracket.l.double m, n bracket.r.double$
\

*Definition 2.6.1* 定义整数集\
$ZZ$ 为 $NN^2$ 对 $sim$ 的商

$NN$ 嵌入 $ZZ$：$ NN &to ZZ \ x &arrow.bar bracket.l.double x, 0 bracket.r.double $

*Definition 2.6.2* 定义和、积\
$ bracket.l.double m, n bracket.r.double + bracket.l.double r, s bracket.r.double &= 
bracket.l.double m + r, n + s bracket.r.double \
bracket.l.double m, n bracket.r.double bracket.l.double r, s bracket.r.double &= 
bracket.l.double m r + n s, n r + m s bracket.r.double $
可以证明是良定义的
（即，等价替换 $(m, n) to (m', n')$，新的运算结果与原先的依然等价）\
注：下文显然的良定义证明均略

满足：
- 加法交换律、结合律，乘法结合律
- 加法零元 $x + 0 = x$，乘法幺元 $x dot 1 = x$
- 加法消去律，乘法对非零元的消去律
- 分配律
注：$x dot 0 = x dot (0 + 0) = x dot 0 + x dot 0$，消去得 $x dot 0 = 0$

定义加法逆元运算：
$-bracket.l.double m, n bracket.r.double = bracket.l.double n, m bracket.r.double$\
进而可定义减法，又有
$x + (-1) dot x = 1 dot x + (-1) dot x = 0 implies (-1) dot x = -x$

*Definition 2.6.4* 定义全序 $leq$\
$ x leq y iff y - x in NN $
#divider

构造 $QQ$

类比 $ZZ$，考虑用 $r/s: (r, s) in ZZ^2, s != 0$

记 $(r, s)$ 所属等价类为 $[r, s]$

*Definition 2.6.6* 定义有理数集\
$QQ$ 为 $ZZ times (ZZ \\ {0})$ 对等价关系
$ sim: (r, s) sim (r', s') iff r s' = r' s $

$ZZ$ 嵌入 $QQ$：$ ZZ &to QQ \ x &to [x, 1] $

加法、乘法：
$ [r_1, s_1] + [r_2, s_2] &= [r_1 s_2 + r_2 s_1, s_1 s_2] \
[r_1, s_1] [r_2, s_2] &= [r_1 r_2, s_1 s_2] $

*Definition 2.6.8* 定义全序\
$ [r, s] geq 0 iff r s geq 0, #tab x geq y iff x - y geq 0 $

记 $QQ^times = QQ \\ {0}$\
*Proposition 2.6.10*\
$forall x in QQ^times$，存在唯一 $x^(-1) in QQ^times$ 使得 $x x^(-1) = 1$\
proof. 存在易得，唯一 $x_1 = x_1 dot 1 = x_1 dot x dot x_2 = 1 dot x_2 = x_2$

*Definition - Proposition 2.6.11* 既约\
$r/s$，$r, s$ 互素。每个有理数有既约表达式，且既约分数满足 
$r_1 / s_1 = r_2 / s_2 iff r_1 = r_2, s_1 = s_2 or r_1 = -r_2, s_1 = -s_2$
#divider

构造 $RR$：需要戴德金分割，或柯西数列

== #三号[2.7 算术]
*Proposition 2.7.1*\
$forall a, d in ZZ, d != 0$，存在唯一 $q, r in ZZ$ 使得 $0 leq r < |d|, a = q d + r$

proof. 存在性：考虑 ${a - q d | q in ZZ} inter NN$ 的最小元。\
唯一性：相减 $r - r' = d(q - q')$

*Lemma 2.7.2*\
$I subset ZZ, I != emptyset$，满足
$ x, y in I &implies x + y in I \ a in ZZ, x in I &implies a x in I $\
存在唯一 $g in NN$ 使得 $I = g ZZ$

proof. 存在性：不妨设 $I != {0}$，否则 $g = 0$ 唯一。取 $g$ 为 $I$ 中最小正整数，则有 $g ZZ subset I$。
若存在 $m = q g + r in I, 0 < r < g$，则 $r = m - q g in I$，与 $g$ 的最小性矛盾。\
唯一性：若 $g ZZ = g' ZZ$，则 $g | g' and g' | g implies g = g'$

#divider

$gcd, lcm$，定义 $gcd, lcm (0, dotc, 0) = 0$\
定义 $limits(sum)_(i = 1)^n ZZ x_i = {limits(sum)_(i = 1)^n a_i x_i in ZZ | a_1, dotc, a_n in ZZ}$，$n = 0$ 时定义为 ${0}$

#divider

*Proposition 2.7.3* É. Bézout（裴蜀定理）\
$ZZ x_1 + dotc + ZZ x_n = gcd(x_1, dotc, x_n) ZZ$\
Corollary：$x_1, dotc x_n$ 互素 $iff$ $exists a_1, dotc a_n in ZZ, sum a_i x_i = 1$

proof. 由 Lemma 2.7.2，存在唯一的 $g$ 使得 $I = sum ZZ x_i = g ZZ$。易知 $forall d | x_i iff d | sum a_i x_i iff d | g$，则 $g$ 确为 $gcd$。\
推论由命题易得。
\

*Definition 2.7.4*\
*素元*：因数只有 $plus.minus 1, plus.minus p$\
*素数*：正的素元
\

*Proposition 2.7.5* Euclid\
素元 $p$，$p | a b implies p | a or p | b$

proof. 不妨 $p divides.not a$，则 $p, a$ 互素，因此存在 $p x + a y = 1$。$b = b(p x + a y) = p b x + a b y$，而 $p | a b$，有 $p | b$
\

*Theorem 2.7.6* 算术基本定理\
$forall n in ZZ, n != 0$，有唯一素因子分解

proof. 存在性：不妨 $n geq 1$。如果 $n != 1, n != p$，则 $n = a b, 1 < a, b < n$，递归\
唯一性：仍不妨 $n geq 1$，若 $n = limits(product)^r p_i^a_i = limits(product)^s q_i^b_i$，有 $p_1 | limits(product)^s q_i^b_i$，
由 Proposition 2.7.5 可得 $p_1 | q_i$，进而 $p_1 = q_i$。若 $a_1 != b_i$，不妨 $a_1 < b_i$，同除，
又由该命题知 $q_i^(b_i - a_1) divides.not p_2^a_2 dotc p_r^a_r$，因此 $a_1 = b_i$。递归可得。\
$r = s = 0$ 时是平凡的。
\

记 $p^a parallel n$ 表示 $p^a | n and p^(a + 1) divides.not n$
\

*Corollary 2.7.8*\
$gcd, lcm$：指数取 $min, max$

*Theorem 2.7.11* Euclid\
存在无穷多个素数

proof. 取 $m = (product p_i) + 1$

== #三号[2.8 同余式]
*Definition 2.8.2* 同余类\
$ZZ$ 对等价关系 $mod N$ 的商集，记为 $ZZ \/ N ZZ$ 或 $ZZ \/ N$。等价类称同余类，$x$ 所属同余类记作 $[x], [x]_N, x mod N$

余数 $R_N(a)$\
有双射 $overline(R_N): ZZ \/ N to {0, dotc, N - 1}$
\

Exercise 2.8.3 说明 $ a equiv b (mod N) implies gcd(a, N) = gcd(b, N) $\
proof. 设 $a = A N + r$，只需证明 $gcd(A N + r, N) = gcd(r, N)$\
记左式为 $d_l$，有 $d_l | N, d_l | r implies d_l | gcd(r, N)$。记右式为 $d_r$，有 $d_r | r, d_r | N implies d_r | gcd(A N + r, N)$\
即 $d_l, d_r$ 相互整除，故相等。\
这是辗转相除法的实质。
\

#divider

*Proposition 2.8.5*\
$(exists y, x y equiv 1 (mod N)) iff gcd(x, N) = 1$

proof. 左式说明 $x y + k N = 1$，则由 Theorem 2.7.3 推论可知 $x, N$ 互素。
\

*Theorem 2.8.9* P. Fermat（费马小定理）\
$forall x in ZZ, gcd(x, p) = 1 implies x^(p - 1) equiv 1 (mod p)$\
Corollary：$forall x in ZZ, x^p equiv x (mod p)$

proof. 由 Proposition 2.8.5，$exists y, x y equiv 1$。考虑 $x$ 的所有整数倍，$k_1 x equiv k_2 x implies k_1 x y equiv k_2 x y implies k_1 equiv k_2$。
另一方面，$p divides.not k$ 时，$k x equiv.not 0$。综上说明，$ k x quad k = 1, dotc, p - 1 $ 互不同余且非零，则为 $1, dotc, p - 1$ 的一个排列。\
相乘得 $ x^(p - 1) (p - 1)! equiv x times 2 x times dotc times (p - 1) x equiv 1 times dotc times (p - 1) equiv (p - 1)! $
，而 $p divides.not (p - 1)!$，故可以约去，即证。\
推论：互素时，成立；不互素，即 $p | x$ 时，两侧均为 $0$ 亦成立。

逆定理不成立。满足逆定理而非素数的数称 Carmichael（卡迈克尔）数，有无穷多个。
\

#divider

*Definition 2.8.7* Euler 函数\
$phi(n)$：不超过 $n$ 且与 $n$ 互素的正整数个数

也是与 $n$ 互素的 $mod n$ 同余类个数，$phi(1) = 1$
\

Exercise 2.8.8 证明 $phi$ 的如下性质：\
(i) 若 $n = product p_i ^ (a_i)$ 为素因子分解，则
$ phi(n) = n product (1 - 1 / p_i) = product (p_i ^ (a_i) - p_i ^ (a_i - 1)) $\
(ii) 若 $n bot m$，则 $phi(n m) = phi(n) phi(m)$\
(iii) $limits(sum)_(d | n) phi(d) = n$\
(iv) $limits(lim)_(n to +inf) phi(n) = +inf$

proof. \
(i) 第二个等号是显然的。观察第一个等号，像是每次剔除一个素因子的所有倍数。\
#tab 只需考虑 $m = product(p_i)$ 的情况，$n$ 是若干个 $m$ 的循环。\
#tab 根据中国剩余定理，$x$ 与向量 $(x mod p_1, dotc x mod p_k)$ 一一对应，各分量彼此独立。
因此指定前面的分量，不影响后续分量的取值。\
#tab 另：也可先证明积性再推导。\
(ii) 类似 CRT，$forall x, y in {0, 1, dotc n m - 1}$
$ cases(reverse: #true, x equiv y (mod n), x equiv y (mod m)) implies x equiv y (mod n m) implies x = y $
#tab 两个余数相互独立，$phi(n m) = phi(n) _text("（与 n 互质）") times phi(m) _text("（与 m 互质）")$\
(iii) $ limits(sum)_(d | n) phi(d) &= limits(sum)_(d | n) product (1 - 1 / p) \
&= limits(sum)_("质因子集合 S") (product (1 - 1 / p)) (limits(sum)_("d 的质因子集合恰为 S") d)\
&= limits(sum)_(S) (product (p - 1) / p) (product (p + p^2 + dotc + p^(a))) "（因数和，每项幂次均非零）"\
&= limits(sum)_(S) (product (p - 1) / p times p (p^a - 1) / (p - 1)) "（等比数列求和，相同质因子乘入）"\
&= limits(sum)_(S) product (p^a - 1) "（对所有子集求和）"\
&= product (p^a - 1 + 1) = n $\
(iv) 若 $n$ 有 $k$ 个质因子，则 $phi(n) = n product (1 - 1 / p) geq n product (1 - 1 / 2) = n / (2^k)$\
#tab 任取 $M > 0$，记 $2^k leq M < 2^(k + 1)$，取 $N = limits(max)_(t = 1)^(k) ( "有 t 个质因子且大于 M 的最小 n" )$ 即可。
\

Exercise 2.8.9 （Möbius 函数）定义 $mu: ZZ^+ to {0, plus.minus 1}$\
$ mu(m) = cases((-1)^("m 的质因子个数") tab &"m 无平方因子", 0 tab &"m 有平方因子") $
证明：(i) $gcd(a, b) = 1 implies mu(a b) = mu(a) mu(b)$\
(ii) $phi(n) = limits(sum)_(d | n) mu(d) n / d$

proof.\
(i) 若 $a b$ 有平方因子，则 $a$ 有或 $b$ 有。否则都没有，也成立。\
(ii) $ sum mu(d) n / d &= n limits(sum)_(S) (-1)^(|S|) limits(product)_(p in S) 1 / p ( "只考虑非零的 mu(d)，枚举质因子的集合" )\ 
&= n limits(sum)_(S) limits(product)_(p in S) (- 1 / p)\
&= n product(- 1 / p + 1) = phi(n) $

== #三号[2.9 集合的基数]
*Definition 2.9.1*\
若存在双射 $f: A to B$，则称 $A, B$ *等势*，或称有相同的*基数*，记作 $|A| = |B|$。\
易知等势是集合间的等价关系，$|A|$ 可以理解为一个等势类。

*Definition 2.9.2*\
若存在 $f: A arrow.hook B$，记作 $|A| leq |B|$\
记 $|A| < |B|$ 为 $|A| leq |B| and |A| != |B|$

可以证明，上述 $leq$ 是偏序，，所有集合组成*全序*集

若 $A$ 和 ${0, 1, dotc, n - 1}$ 等势，记 $|A| = n$。$|emptyset| = 0$\
定义有限集：$exists n in NN$，使得 $|A| = n$；反之为无限集。

在有限集中，基数相当于集合的大小。

#divider

*Proposition 2.9.4* 抽屉原理\
$|A| = |B|$，则任何单射或满射 $f: A to B$ 自动是双射。

*Proposition 2.9.5*\
$A$ 无穷当且仅当存在单射 $NN arrow.hook A$。

Exercise 2.9.6\
设 $A$ 是无限集证明：存在单而非满（或满而非单）的映射 $f: A to A$\
proof. 因为无限，则存在单射 $g: NN to A$。考虑如下构造
$ f(a) = cases(g(2k) space &mathrm(i f) space exists k > 0 space g(k) = a, 
g(1) space &mathrm(i f) space g(0) = a, 
g(0) &mathrm(i f) space forall k in NN space g(k) != a) $
易知 $f$ 单。当 $|NN| < |A|$ 时 $f$ 必不满，而 $|NN| = |A|$ 时大于 1 的奇数映射的 $a$ 无 $f$ 的原像，亦不满。

#divider

$NN$ 视为有限基数，可以按如下扩展：
- 加法：无交并 $|A| + |B| = |A union.sq B|$
- 乘法：积集 $|A| dot |B| = |A times B|$
- 指数：映射集 $|A|^(|B|) = |A^B|$（见 2.3）

幂集：\
记 $mathbf(1)_S: A to {0, 1}$ 表示在 $S subset A$ 上取 1，在 $A \\ S$ 上取 0。\
考虑 $f in {0, 1}^A$（见 2.3，映射集实际为映射的集合），$f$ 将 $A$ 的每个*元素*映射到 0 或 1。记 $S$ 为被映射为 1 的元素的集合，即 $S = f^(-1)(1)$。
这是 $f$ 到 $S$ 的单射。\
考虑 $S in P(A)$，$mathbf(1)_S in {0, 1}^A$。这是 $S$ 到 $f$ 的单射。\
因此，存在双射 ${0, 1}^A to P(A)$，则二者等势。故有 $ 2^(|A|) = |{0, 1}|^(|A|) = |{0, 1}^A| = |P(A)| $
换言之，基数代表集合的大小，对幂集也成立。

#divider

Proposition 2.9.5 断言无穷集总包含一份 $NN$ 的副本，因此 $|NN|$ 是最小的无穷基数。

*Definition 2.9.7* 阿列夫零\
记 $aleph_0 = |NN|$。满足 $|A| = aleph_0$ 的集合称*可数集*或*可列集*。满足 $|A| leq aleph_0$ 的集合称*至多可数集*，即 $A$ 要么有限，要么可数。

*Proposition 2.9.8*\
有限多个可数集的并和积依然可数。\
proof. 并：只需说明无交并满足即可。
$ NN union.sq.big NN to NN $
令第一个 $x to 2x$，第二个 $x to 2x + 1$\
积：$ NN times NN &to NN \ (a, b) &arrow.bar 2^a(2b + 1) - 1 $\
均为双射。

*Annotation 2.9.9* Proposition 2.9.8 的推广\
任意两个集合的基数 $kappa, gimmel$，其中至少一者为无穷，有 $kappa dot gimmel = max{kappa, gimmel} = kappa + gimmel$。
上述命题是 $kappa = gimmel = aleph_0$ 的特例。证明略。

*Corollary 2.9.10*\
设 $(A_i)_(i in I)$ 是一族可数集，且下标集 $I$ 本身可数，则 $union.big_(i in I) A_i$ 可数。\
proof. $forall i in I$，选一个双射 $f_i: NN to A_i$，进而定义
$ phi: I times NN &to limits(union.big)_(i in I) A_i \ (i, n) &arrow.bar f_i(n) $
$phi$ 必为满射，有 $|limits(union.big)_(i in I) A_i| leq |I| dot aleph_0 = aleph_0 dot aleph_0 = aleph_0$。而每个 $A_i$ 为无穷集，则并集依然为无穷集。
故 $|limits(union.big)_(i in I) A_i| = aleph_0$。\
将所有“可数”均换为“至多可数”亦成立。

Example 2.9.11\
$ZZ = ZZ_(geq 0) union ZZ_(leq -1)$，整数集可数\
$QQ = union.big 1/n ZZ = union.big {r/n | r in ZZ}, space n in NN \\ {0}$，有理数集可数

#divider

*Theorem 2.9.12* G. Cantor\
$forall A$，有 $2^(|A|) = |P(A)| > |A|$\
proof. 有单射 $ f: A &to P(A) \ a &arrow.bar {a} $
则 $|A| leq |P(A)|$，下面说明不等号为严格的，即证对任意映射 $f: A to P(A)$ 非满。\
取 $B = {a in A | a in.not f(a)} subset A$。若 $f$ 满，则 $exists a_0 in A, space f(a_0) = B$。考虑 $a_0$ 与 $f(a_0)$ 的关系：\
- $a_0 in f(a_0) space implies space a_0 in.not B space arrow.r.double.long^(B = f(a_0)) space a_0 in.not f(a_0)$
- $a_0 in.not f(a_0) space implies space a_0 in B space arrow.r.double.long^(B = f(a_0)) space a_0 in f(a_0)$
总有矛盾，故假设不成立，得证。这与罗素悖论（理发师悖论）有异曲同工之妙。\

== #三号[Exercise]
7. 设偏序集 $(P, prec.eq)$ 的所有非空子集皆有极大元。证明若单射 $theta: P to P$ 满足 $x prec.eq theta(x)$，则 $theta = mathrm(i d)_P$。
   
proof. 反证。取 $S = {x in P | theta(x) != x}$，则 $S != emptyset$，有最大元 $M$。\
$M prec theta(M) implies theta(M) in.not S implies theta(M) = theta(theta(M))$，又与 $theta$ 单矛盾。
#divider

11. 设 $x in RR$ 而 $a, b in NN^+$，证明 $floor.l frac(x, a b) floor.r = floor.l frac(floor.l x \/ a floor.r , b) floor.r$。

proof. 记 $x = lambda a b + r$，其中 $r = mu a + omega in [0, a b), mu = floor.l r \/ a floor.r in [0, b), omega = r mod a$。\
$ floor.l x \/ a floor.r &= lambda b + mu \ 
floor.l frac(floor.l x \/ a floor.r , b) floor.r &= lambda $
#divider

16. 证明 $[0, 1]$ 的基数是 $2^(aleph_0)$。

proof. 取二进制。
#divider

17. 对任意集合 $S$ 定义 $ C_S = {f: S to {0, 1} | f^(-1)(1) "有限"} $ 证明：当 $S$ 有限时 $|C_S| = 2^(|S|)$；当 $S$ 无穷时 $|C_S| = |S|$。
proof. $S$ 有限，任意 $f$ 均可，共 $2^(|S|)$ 个。\
$S$ 无穷，
$ |C_S| &= |1| + |S| + |S times S| + |S times S times S| + dotc "（枚举映为 1 的元素个数，算多元组）" \ 
&= |1| + |S| + |S| + |S| + dotc "（Annotation 2.9.9）" \
&= |S| $

#newpage

= #二号[3. 环，域和多项式]
默认：$R$ 表示环、整环、交换环，$F$ 表示域。

== #三号[3.1 环和域]
*Definition 3.1.1* 环\
资料 $(R, +, dot, 0_R, 1_R)$，$0_R, 1_R in R$，$+,dot: R times R to R$。满足：
- 加法：结合律，交换律，零元性质，加法逆元
- 乘法：结合律，幺元性质
- 乘法对加法：分配律
简记为 $R$。

可以推出，$0_R, 1_R$ 唯一，加法逆元唯一，加法消去律，负负得正。

#divider

零环：$0 = 1$，只有单个元素\
非零环：必然有 $0 != 1$\
$n in ZZ, r in R$，可定义 $n r$

#divider

*Definition 3.1.2* 子环\
$R' subset R, 0, 1 in R'$，且 $+, dot$ 和加法取逆对 $R'$ 封闭。

Example 3.1.4 中心\
$Z(R) := {z in R | forall x in R, z x = x z}$

*Definition 3.1.3* 乘法逆元，左右逆，可逆；可逆元构成的子集称 $R^times$

*Definition 3.1.8* 交换环：有乘法交换律的环\
交换环 $iff Z(R) = R$

*Definition 3.1.9* 关于乘法逆元
- 除环：$R^times = R \\ {0}$（排除了零环）
- 域：交换除环
子域：构成域的子环

*Definition 3.1.11* 整环\
$x, y != 0 implies x y != 0$，意即有乘法消去律。

域自动是整环：$x != 0, x y = 0 implies y = x^(-1) x y = 0$

e.g. $CC$ 是域，$RR, QQ$ 是 $CC$ 的子域；$ZZ$ 是整环，不是域。

#divider

#diagram(
  spacing: (5mm, 5mm),
  {
    let (r, d, s, f, z) = ((0, -1), (-1, 0), (1, 0), (0, 1), (1, 1))
    node(r, "环")
    node(d, "除环")
    node(s, "交换环")
    node(f, "域")
    node(z, "整环")
    
    edge(r, d, $x^(-1)$, "->")
    edge(r, s, $x y = y x$, "->")
    edge(d, f, $x y = y x$, "->", label-side: right)
    edge(s, f, $x^(-1)$, "->")
    edge(s, z, 六号[乘法消去律], "->", label-side: left)
    edge(z, f, $x^(-1)$, "->", label-side: left)
  }
)

#divider

Example 3.1.12 同余\
$(ZZ \/ N ZZ)^times = {[x]: x in ZZ, x perp N}$\
$|(ZZ \/ N ZZ)^times| = phi(N)$\
$ZZ \/ N ZZ$ 为域 $iff$ $phi(N) = N - 1$ $iff$ $N$ 是素数

另记 $FF_p := ZZ \/ p ZZ$。

Example 3.1.13 环的直积\
构造新环。逐分量定义，或映射集 $R^I$，同映射。

== #三号[3.2 同态和同构]
*Definition 3.2.1* 环同态\
$f: R to R'$，满足：
- $f(x + y) = f(x) + f(y)$
- $f(x y) = f(x) f(y)$
- $f(1_R) = 1_(R')$

自同态：$f: R to R$

性质：
- 自动保持零元：$f(0_R) = f(0_R + 0_R) = f(0_R) + f(0_R) implies f(0_R) = 0_(R')$
- 保持加法逆、乘法逆（称，同态映可逆元为可逆元）
- 同态的合成仍同态
- 像 $f(R)$ 是 $R'$ 子环

#divider

*Definition 3.2.2* 环同构\
$f: R to R'$ 与 $g: R' to R$，满足 $f g = mathrm(id)_R$ 且 $g f = mathrm(id)_(R')$。逆。

*Proposition 3.2.5* 作为集合间的双射的环同态是环同构。\
proof. $g(1) = g(f(1)) = g f(1) = 1$\
$g(x + y) = g(f(a) + f(b)) = g(f(a + b)) = g f(a + b) = a + b = g(x) + g(y)$\
$g(x y) = g(f(a)f(b)) = g(f(a b)) = g f(a b) = a b = g(x)g(y)$

同构的合成仍同构。

*Annotation 3.2.6* 记作 $f: R arrow.r.tilde R'$，$R tilde.eq R'$

#divider

*Theorem 3.2.8* 中国剩余定理\
$N = product p_i$，$p_i$ 两两互素，有环同构：
$ phi: &ZZ \/ N ZZ &arrow.r.long^sim &product_(i = 1)^k ZZ \/ p_i ZZ \
&[x]_N &arrow.bar.long &([x]_(p_i))_(i = 1)^(k) $\
proof. 两端集合大小相等，只需 $phi$ 单。而 $phi(x) = phi(y) implies forall p_i | x - y implies N | x - y$

#divider

Exercise 3.2.10 设 $D_1$ 和 $D_2$ 为无平方因子的非零整数，均不为 1。定义二次域 $QQ(sqrt(D)) := {a + b sqrt(D) | a, b in QQ}$。\
证明：$QQ(sqrt(D_1)) tilde.eq QQ(sqrt(D_2)) iff D_1 = D_2$

proof. 只需说明左推右。记 $f: QQ(sqrt(D_1)) to^sim QQ(sqrt(D_2))$
- Lemma I：$A in NN \\ {0, 1}$ 且无平方因子，则 $x^2 = A$ 在 $QQ(sqrt(D))$ 有解当且仅当 $A = D$。\
  $ (a + b sqrt(D))^2 = (a^2 + b^2 D) + 2 a b sqrt(D) implies cases(a^2 + b^2 D = A, a b = 0) $\
  $b = 0 implies a^2 = A$ 与题设矛盾。\
  $a = 0 implies b^2 D = A$，由题设则 $b^2 = 1 implies A = D$
- Lemma II：$forall a in QQ, f(a) = a$\
  由同构，有 $f(1) = 1$，推广至 $forall a in ZZ, f(a) = a$\
  进而 $f(a^(-1)) = (f(a))^(-1) = a^(-1)$\
  再依乘法，得证。\
同构使结构相同，由 Lemma I 知 $f(D_1) = D_2$。继而由 Lemma II 得 $D_1 = D_2$。

== #三号[3.3 多项式环]
*Definition 3.3.1* 多项式\
$f = sum a_n X^n, a_n in R$，至多有限个 $a_n != 0$\
$f$ 为形式和。所有多项式构成的集合记作 $R[X]$

首一多项式：首项为 1 的多项式，即最高非零项的系数。\
零多项式：记为 0\
常数多项式：除常数外系数全 0。这使得 $R$ 嵌入 $R[X]$

多项式非零：$f in R[x] \\ {0}$，与取值无关。\
规定 $deg 0 = -inf$

*Proposition 3.3.2* 多项式环\
正常多项式加法与乘法，$0_(R[X]) = 0, 1_(R[X]) = 1_R$。$R[X]$ 成为环。\
若 $R$ 交换，则 $R[X]$ 亦交换。

*Lemma 3.3.3* 整环\
$R$ 整，则 $f, g in R[X], f, g != 0$ 有 $deg (f g) = deg f + deg g$。此时 $R[X]$ 整。\
推论：$R[X]^times = R^times$

proof. 考虑最高次项。

多元多项式环 $R[X, Y, dotc]$：允许无穷多个变量，但只允许有限和。

区分多项式与多项式函数。\
e.g. 考虑 $R = FF_p$，$f(X) = x^p - X$ 作为函数与零函数无异。

*Proposition 3.3.7* $R[X, Y] tilde.eq (R[X])[Y]$，推广有 
$R[X_1, dotc, X_n] tilde.eq R[X_1, dotc, X_(n - 1)][X_n] tilde.eq dotc tilde.eq R[X_1] dotc [X_n]$

proof. 记 $ phi: &R[X, Y] &to &R[X][Y] \ &sum c_(a b) X^a Y^b &arrow.bar &sum (sum c_(a b) X^a) Y^b $\
证明：$phi$ 是环同态，也是双射。\
- 环同态\
  - 加法：显然
  - 乘法：\
    Lemma 对子集归纳：假设 $forall s, t in S$ 有 $phi(s t) = phi(s) phi(t)$。则当 $s, t$ 为 $S$ 中的元素的有限和时：\
    $ phi(sum s_i sum t_j) = phi(sum s_i t_j) =^("加法") sum phi(s_i t_j) 
    =^("归纳假设") sum phi(s_i) phi(t_j) = sum phi(s_i) sum phi(t_j) = phi(s) phi(t) $\
    取所有单项式的集合 $S$，归纳奠基。
- 双射\
  $phi^(-1)$ 可显式写出。

*Corollary 3.3.8* 整环\
$R$ 整，则 $R[X, Y, dotc]$ 整，且 $R[X, Y, dotc]^times = R^times$。

proof. 依命题 3.3.7 递归论证。

== #三号[3.4 一元多项式除法]
*Proposition 3.4.1* 多项式带余除法\
在 $F[X]$ 上， $a = q d + r$。其中 $d != 0, deg r < deg d$（允许 $deg r = -inf$）。\
类似整数的情形，也用整除记号。

Exercise 3.4.2 $F[X]$ 换成整环 $R[X]$，若 $d$ 的最高次项属于 $R^times$，命题 3.4.1 仍成立。

*Proposition 3.4.4* 根的个数\
$f in F[X] \\ {0}$，则 $f$ 在 $F$ 中*至多*有 $deg f$ 个相异的根。（因此这不是代数基本定理）

proof. 对次数归纳。$deg = 0$ 时成立是显然的。假设对 $deg = n - 1$ 成立，当 $deg = n$ 时：\
反证，若 $f$ 有 $n + 1$ 个相异根 $r_1, dotc r_(n + 1)$。考虑 $f = (X - r_(n + 1))g$（因式定理）。\
$forall t <= n, g(r_t) = f(r_t) / (r_t - r_(n + 1)) = 0$，则 $g$ 至少有 $n$ 个相异根，与 $deg g = n - 1$ 矛盾。

== #三号[3.5 分式域与有理函数域]
*Definition - Proposition 3.5.1* 分式域\
整环 $R$ 的分式*域*记为 $mathrm(F r a c)(R)$，具体定义完全同 $ZZ$ 到 $QQ$ 的构造。\
$mathrm(R a d i o)(R) := {(f, g) in R^2: g != 0}\
mathrm(F r a c)(R) := mathrm(R a d i o)(R) \/ ~$

#divider

*Proposition 3.5.3* 设 $R$ 整，$R'$ 交换，$phi: R to R'$ 为环同态，使得 $phi(R \\ {0}) subset (R')^times$。
此时存在唯一的环同态 $Phi: mathrm(F r a c)(R) to R'$，使得有如下的交换图表：\
#diagram(
  spacing: (5mm, 5mm),
  {
    let (R, r, frac) = ((0, 0), (1, 0), (0, 1))
    node(R, $R$)
    node(r, $R'$)
    node(frac, $mathrm(F r a c)(R)$)

    edge(R, r, $phi$, "->")
    edge(R, frac, "hook->")
    edge(frac, r, $Phi$, "->", label-side: right)
  }
)\
具体地，$Phi$ 映 $f \/ g$ 为 $phi(f) phi(g)^(-1)$。

proof. 
- 唯一性：若存在 $Phi$\
  $forall g in R \\{0}, 1 = Phi(g / 1 dot 1 / g) = Phi(g / 1) Phi(1 / g) = phi(g) Phi(1 / g) implies Phi(1 / g) = phi(g)^(-1)$\
  因而 $Phi(f / g) = Phi(f / 1 dot 1 / g) = Phi(f / 1) Phi(1 / g) = phi(f) phi(g)^(-1)$\
  所以是唯一的。
- 存在性\
  定义 $limits(Phi)^~: mathrm(R a d i o)(R) to R', limits(Phi)^~(f, g) = phi(f) phi(g)^(-1)$\
  $f_1 g_2 = f_2 g_1 implies phi(f_1)phi(g_2) = phi(f_2)phi(g_1) implies limits(Phi)^~(f_1, g_1) = limits(Phi)^~(f_2, g_2)$\
  依 Proposition 2.5.5 可得 $Phi$。

*Corollary 3.5.4* 整环 $R$ 是域 $F$ 的子环，且 $F$ 的所有元素可以表示为 $f g^(-1), f, g in R, g != 0$ 的形式。
则存在唯一环同构 $Phi: mathrm(F r a c)(R) to F$，使得有如下的交换图表：\
#diagram(
  spacing: (10mm, 5mm),
  {
    let (r, f, frac) = ((0, 0), (1, 0), (0, 1))
    node(r, $R$)
    node(f, $F$)
    node(frac, $mathrm(F r a c)(R)$)

    edge(r, f, 六号[包含映射], "hook->")
    edge(r, frac, "hook->")
    edge(frac, f, $Phi \ ~$, "->", label-angle: auto, label-side: center, label-fill: false)
  }
)\

proof. Proposition 3.5.3 给出唯一环同态 $Phi$，证明其既单又满。
- 单\
  $Phi(f_1 \/ g_1) = Phi(f_2 \/ g_2) arrow.r.long^(times Phi(g_1 g_2)) Phi(f_1 g_2) = Phi(f_2 g_1)$，\
  则 $f_1 g_2, f_2 g_1 in R$ 在包含映射下的像相同，继而 $f_1 g_2 = f_2 g_1 implies f_1 \/ g_1 = f_2 \/ g_2 in mathrm(F r a c)(R)$。
- 满\
  $forall x in F, x = f g^(-1)$，而 $Phi(f \/ g) = f g^(-1) = x$。

这说明，可以从 $F$ 中提取 $R$，又能从 $R$ 构造 $F$。没有损失信息。

#divider

*Definition 3.5.5* 分式域在多元情形上的推广\
$F[X, Y, dotc]$ 的分式域称有理函数域，记为 $F(X, Y, dotc)$。

Exercise 3.5.6 在整环 $R$ 上考虑分式域。试给出 $mathrm(F r a c)(R[X]) tilde.eq mathrm(F r a c)(R)(X)$，\
以及多元情形也有 $mathrm(F r a c)(R[X, Y, dotc]) tilde.eq mathrm(F r a c)(R)(X, Y, dotc)$。

proof. 沿用分式域的等价类刻画。相当于分子、分母同乘常数，将上下的有理系数化为整系数。

*Definition 3.5.7* 次数在一元有理函数上的推广\
$forall h = f \/ g in F(x)$，当 $h != 0$ 时定义 $deg h := deg f - deg g$。规定 $deg 0 = -inf$

易验证是良定义的，类似分式域构造时。

性质：
- $deg(f g) = deg f + deg g$
- $deg(f + g) leq max{deg f, deg g}$

== #三号[3.6 多项式函数]
多项式与多项式函数并非一一对应。\
交换环 $R$，记 $mathrm(F c n): R[X_1, dotc X_n] to {"函数" phi.alt: R^n to R}$\
多项式可视为函数，当且仅当 $mathrm(F c n)$ 是单射。\
$mathrm(F c n)(f) = mathrm(F c n)(g) iff mathrm(F c n)(f - g) = 0 iff mathrm(F c n)^(-1)("零函数") = {0}$

*Lemma 3.6.1* Proposition 3.4.4 在整环上的推广\
$R$ 整，$f in R[X] \\ {0}$，则 $f$ 在 $R$ 中至多有 $deg f$ 个根。

proof. $R$ 嵌入 $F := mathrm(F r a c)(R)$，用 Proposition 3.4.4。

*Proposition 3.6.2* 多项式视同函数的更简单条件\
整环 $R$，$mathrm(F c n): R[X_1, dotc, X_n] to {"函数" R^n to R}$ 是单射当且仅当 $R$ 有无穷多个元素。

proof.
- 左推右\
  反证。若 $R$ 有限，有反例 $f = product_(a in R) (X_1 - a)$，非单射。
- 右推左\
  只需证明，$mathrm(F c n)(f) = 0 iff f = 0$。\
  对变元数量 $n$ 归纳。$n = 1$ 时，$f != 0$ 则能找到 $deg f + 1$ 个相异的根（$R$ 无穷），与 Lemma 3.6.1 矛盾。\
  $n > 1$ 时，以 $X_n$ 为主元整理，化为 $n = 1$ 的情况。可知 $f$ 的各项系数皆为 $0$，而每个系数是至多 $n - 1$ 次的多项式，递归即可。

*Theorem 3.6.3* 代数等式的延拓原理\
无穷整环 $R$，$f, g_1, dotc, g_m in R[X_1, dotc, X_n]$ 且 $g_1, dotc, g_m != 0$。若 $forall (x_1, dotc, x_n) in R^n$ 有
$ (g_1(x_1, dotc, x_n) != 0 and dotc and g_m (x_1, dotc, x_n) != 0) implies f(x_1, dotc, x_n) = 0 $
则 $f = 0$。

proof. $f product g_i$ 在所有 $(x_1, dotc, x_n) in R^n$ 都取 0，由 Proposition 3.6.2 为零函数。而 $R[X_1, dotc, X_n]$ 为整环，故 $f = 0$。

这说明，一个代数方程 $f = 0$ 在 $g_1, dotc g_m != 0$ 的一般情形成立，则在某个 $g_i = 0$ 的例外情况自动成立，如果 $R$ 为无穷整环。
又称扰动法。

== #三号[3.7 域的特征]
对于 $F in {QQ, RR, CC}$，$n dot 1_F = 0_F iff n = 0$。\
但对于 $F in {FF_p, FF_p(X)}$，$p dot 1_F = 0_F$。

*Lemma 3.7.1* $ZZ$ 到 $R$ 的映射\
对任意环 $R$，存在唯一环同态 $ZZ to R$，且唯一的映法是 $n arrow.bar n dot 1_R$。

proof. 
- 唯一性：环同态映 1 为 $1_R$\
  从而映 $n geq 0$ 为 $underbracket(1_R + dotc + 1_R, n "个") = n dot 1_R$\
  继而映 $n leq 0$ 为 $-(|n| dot 1_R) = n dot 1_R$
- 存在性：只需验证该映法确实是环同态。

考虑 $K_R := {n in ZZ: n dot 1_R = 0_R} subset ZZ$。$K_R$ 包含 0，对加法封闭。\
又 $n in K_R, m in ZZ implies m n dot 1_R = (m dot 1_R) (n dot 1_R) = 0_R implies m n in K_R$。\
由 Lemma 2.7.2，存在唯一 $g in NN$，使 $K_R = g ZZ$。

*Definition - Proposition 3.7.2* 特征\
整环 $R$，存在唯一 $"char"(R) in NN$ 使 $forall n in ZZ$ 有 
$ n dot 1_R = 0_R iff "char"(R) | n $
称为整环 $R$ 的特征。它或是 0，或是素数。\
（$"char"(R) = 1$ 将导致零环）

proof. 由前知存在唯一 $"char"(R) in NN, K_R = "char"(R)ZZ$。当 $"char"(R) != 0$ 时，且有因数分解 $"char"(R) = a b$。由环同态，
$ "char"(R) dot 1_R = (a dot 1_R)(b dot 1_R) = 0_R implies a in K_R or b in K_R implies "char"(R) | a or "char"(R) | b $
足以说明其为素数。

Exercise 3.7.3 素数 $p$，$R$ 为满足 $p dot 1_R = 0_R$ 的交换环。证明：$forall x, y in R$ 有 $(x + y)^p = x^p + y^p$。

proof. 展开。$forall 0 < k < p, vec(p, k) = p(p - 1)dotc(p - k + 1) / k! = 0$。

#divider

*Proposition 3.7.4* 子环特征不变\
若 $R_0$ 是整环 $R$ 的子环，则 $"char"(R_0) = "char"(R)$。

proof. 显然 $R_0$ 也为整环。$1_(R_0) = 1_R$，等式 $n dot 1_R = 0_R$ 是否成立可以在子环中判定。

$R subset "Frac"(R) implies "char"("Frac"(R)) = "char"(R)$

Exercise 3.7.5 环同态存在性与特征\
域 $E, F$，且 $"char"(E) != "char"(F)$。说明不存在 $E$ 到 $F$ 的环同态。

proof. 反证。存在 $phi: E to F$，由 Exercise 3.2.7 知 $phi$ 必单射。\
  $phi("char"(F) dot 1_E) = phi(underbracket(1_E + dotc + 1_E, "char"(F)"个")) 
  = underbracket(1_F + dotc + 1_F, "char"(F)"个") = 0_F = phi(0_E)$。不是单射，矛盾。

因此，不同特征的域不能直接沟通。

#divider

域 $F$ 的特征取决于 $QQ$ 或 $FF_p$ 能否嵌入其中作为子域。
- $"char"(F) = 0$\
  同态 $ZZ to F$ 是单的。$F$ 的非零元都可逆。
  $ QQ = "Fr"&"ac"(ZZ) &to &F \
  &a / b &arrow.bar &(b dot 1_F)^(-1)(a dot 1_F) $
  这是 Proposition 3.5.3 的一则应用，也说明该嵌入方式是唯一的。
- $"char"(F) = p > 0$\
  $n dot 1_F$ 只与 $n mod p$ 有关。
  $ &FF_p &arrow.r.long &F \ n + &p ZZ &arrow.bar.long &n dot 1_F $
  也是唯一的。

反过来，若 $QQ$ 或 $FF_p$ 能嵌入，由 Proposition 3.7.4 说明 $"char"(F) = 0$ 或 $p$。

从 $0_F, 1_F$ 出发，经四则运算得到的最小子域或是 $QQ$ 的副本，或是 $FF_p$ 的副本。这一最小子域称 $F$ 的*素域*。

== #三号[Exercise]
2. 证明有限整环必为域

proof. $forall x != 0, x dot a = x dot b implies x (a - b) = 0 implies a = b$。同理。
因此左右乘映射皆单，又有限，必满。所以左右逆皆存在，而存在必相等。

#divider 

3. (Wilson Theorem) 素数 $p$，运用 $FF_p$ 为域的事实证明 $(p - 1)! equiv -1 (mod p)$
   
proof. $1 ~ p - 1$ 按 $(x, x^(-1))$ 配对。其中 $(1, 1), (p - 1, p - 1)$ 自配对，其余都两数不同。

#divider

4. 素数 $p$，考虑 $FF_p [X]$。\
  (i) 设 $n in NN_+$ 的 $p$ 进制展开为 $n = sum a_k p^k$，证明 $FF_p [X]$ 中的等式：
      $ (X + 1)^n = product (X^(p^k) + 1)^(a_k) $
  (ii) (É. Lucas) 设 $n, m in NN_+$，$p$ 进制展开为 $n = sum a_k p^k, m = sum b_k p^k$。证明 $vec(n, m)$ 满足：
      $ vec(n, m) equiv product vec(a_k, b_k) (mod p) $

proof. (i) $ (X + 1)^n &= product ((X + 1)^(p^k))^(a_k)\
&= product ((X^p + 1)^(p^(k - 1)))^(a_k) quad ("Exercise 3.7.3")\ &= dotc\
&= product (X^(p^k) + 1)^(a_k) $\
(ii) $ [X^m](X + 1)^n &= vec(n, m)\
[X^m](X + 1)^n &equiv [X^m] product (X^(p^k) + 1)^(a_k)\
&equiv [X^m] product (sum vec(a_k, t) X^(t dot p^k)) quad ("其中" 0 leq t leq a_k < p)\
&equiv product vec(a_k, b_k) quad ("有且仅有一种合法的选法凑出" m) $

#divider

5. (R. Stanley) 设 $n in NN_+$，而 $zeta in CC^times$ 为任意 $n$ 次单位原根。\
  (i) 定义 $f = limits(product)_(k = 1)^n (1 + X^k) in CC[X]$，展开后记为 $sum a_k X^k$。证明：
      $ 1 / n limits(sum)_(j = 1)^n f(zeta^j) = sum a_(j n) $
  (ii) $forall j in NN_+$，记 $d = n \/ gcd(j, n)$，研究 $X^d - 1$ 的分解以推导：
      $ (1 + zeta^j) dotc (1 + zeta^(d j)) = cases(2 space &"if d is odd", 0 space &"if d is even") $
      $ f(zeta^j) = cases(2^(n \/ d) space &"if d is odd", 0 space &"if d is even") $
  (iii) 证明：
      $ (ZZ \/ n ZZ "中元素和为" 0_(ZZ \/ n ZZ) "的子集个数") = 1 / n limits(sum)_(d | n \ d "is odd") phi(d) 2^(n \/ d) $
      此处的子集容许为空集，其元素和定义为 $0_(ZZ \/ n ZZ)$

proof. (i) $"LHS" = 1 / n sum_j sum_t a_t zeta^(j t) = 1 / n sum_t a_t (zeta^t + zeta^(2t) + dotc + zeta^(n t))$\
#tab $n divides.not t$ 时，$zeta^t$ 为 $n \/ gcd(n, t)$ 次单位根，共 $gcd(n, t)$ 组。每组和均为 0。\
#tab $n | t$ 时，$zeta^t = 1$，则 $zeta^t + dotc + zeta^(n t) = n$\

(ii) $zeta^j$ 是 $n \/ gcd(n, j) = d$ 次单位根。\
#tab 记 $g(X) = X^d - 1 = limits(sum)_(k = 1)^d (X - omega_d^k) = sum (X - zeta^(k j))$\
#tab $g(-1) = (-1)^d - 1 = (-1)^d sum(1 + zeta^(k j))$ 得第一个等式。\
#tab $f(omega_d) = (limits(sum)_(k = 1)^d (1 + omega_d^k))^(n \/ d)$ 结合等式一得等式二。

（iii) 引理：给定 $d$，使得 $n \/ gcd(n, j) = d$ 的 $j leq n$ 有 $phi(d)$ 个。\
#tab 记 $g = gcd(n, j) = n \/ d$，则 $j$ 为 $g$ 的倍数，即 $g, 2g, dotc, d g$。\
#tab 另一方面，记 $n = d g, j = k g$，要求 $d perp k$，故共 $phi(d)$ 个。
      $ "LHS" &= sum [X^(k n)] f(X) quad ("GF")\
        &=^("(i)") 1 / n limits(sum)_(j = 1)^n f(zeta^j) = 1 / n limits(sum)_(j = 1)^n f(omega_(n \/ gcd(n, j))\
        &= 1 / n limits(sum)_(d | n) phi(d) f(omega_d) quad ("let" d = n \/ gcd(n, j))\
        &=^("(ii)") 1 / n limits(sum)_(d | n \ d "is odd") phi(d) 2^(n \/ d) $
    
#divider

7. （布尔环）环 $R$，满足 $forall r in R, r^2 = r$。证明：$R$ 交换。
   
proof. $forall x in R, x + x = (x + x)^2 = 4x^2 = 4x implies x + x = 0 implies x = -x$\
#tab $forall a, b in R, a + b = (a + b)^2 = a^2 + a b + b a + b^2 = a + a b + b a + b\
implies a b + b a = 0 implies a b = -b a = b a$

#divider

9. (N. Jacobson) 环 $R$，$x, y in R$。证明若 $1 - x y$ 可逆，则 $1 - y x$ 可逆，且
  $ (1 - y x)^(-1) = 1 + y(1 - x y)^(-1)x $

证明只需验算。注意力源自数学分析，*形式*地操作无穷级数（意即等号未必成立）：
$ (1 - y x)^(-1) &= 1 + y x + y x y x + dotc\
&= 1 + y(x + x y x + x y x y x + dotc)\
&= 1 + y(1 + x y + x y x y + dotc)x\
&= 1 + y(1 - x y)^(-1)x $

#divider

13. 奇素数 $p$，证明：\
#tab (i) $a^2 equiv b^2 (mod p) iff a equiv plus.minus b (mod p)$\
#tab (ii) $exists a, b in ZZ$ 使得 $p | a^2 + b^2 + 1$。

proof. (i) 移项，平方差，略。\
(ii) $plus.minus x to x^2$，因而 $forall x, x^2 mod p$ 有 $(p + 1) \/ 2$ 种取值。\
#tab 题意即 $exists a, b in ZZ$ 使得 $a^2 equiv -1 - b^2 (mod p)$。左右式各有 $(p + 1) \/ 2$ 种取值，由抽屉原理知必有相同值。

#divider

14. 素数 $p$，定义 $ZZ_((p)) := {a / b in QQ: a, b in ZZ, p divides.not b}$\
#tab (i) 证明 $ZZ_((p))$ 是 $QQ$ 的子环。\
#tab (ii) 域 $F$，$"char"(F) in {p, 0}$。说明存在唯一的环同态 $ZZ_((p)) to F$

proof. (i) 略。\
#tab (ii) 存在性是容易的。由 $1 \/ 1$ 的像为 $1_F$ 并结合四则运算，可以唯一确定环同态，唯一性也得证。

#divider

16. (Cartan–Brauer–华罗庚) 除环 $D$，子环 $R$，且 $R$ 本身也为除环。若 $forall d in D^times$ 有 $d R d^(-1) subset R$，
则必有 $R = D$ 或 $R subset Z(D)$。\
#tab Hint: 若 $a, b in D$ 满足 $a b != b a$，则 
$ a = (b - (a - 1)^(-1) b (a - 1)) (a^(-1) b a - (a - 1)^(-1) b (a - 1))^(-1) $

proof. 
- I. Hint 中的等式验算即可，但成立条件值得探讨。需 $a, (a - 1), (a^(-1) b a - (a - 1)^(-1) b (a - 1))$ 都可逆，即不为 0。\
#tab $a = 0 or a - 1 = 0 implies a = 0 or 1 implies a b = b a$\
#tab $a^(-1) b a = (a - 1)^(-1) b (a - 1) iff (a - 1) a^(-1) b a = b(a - 1) iff (1 - a^(-1)) b a = b a - b
iff a^(-1) b a = b iff b a = a b$\
#tab 因此都被 $a b != b a$ 涵盖。
- II. 记 $W = {a in D: forall b in R a b = b a}$。$forall a in D$：\
#tab - $exists b in R, a b != b a$。\
#tab #tab 这蕴涵 $a, a - 1 in D^times$，由题设 $(a - 1)^(-1) b (a - 1), a^(-1) b a in R$，继而由除环性质与子环的运算封闭性得 $a in R$。\
#tab - $forall b in R, a b = b a$\
#tab #tab 这说明 $a in W$。\
#tab 综上，$a in R or a in W implies D = R union W$。\
#tab 简单论证可得 $W$ 对加法和加法取逆运算封闭，而 $R$ 和 $D$ 也如此。故只能 $R subset W subset Z(D)$ 或 $W subset R implies R = D$。

#divider

17. 举例说明存在环 $R$ 与 $x in R$，使得 $x$ 不可逆，但存在无穷多个 $y$ 满足 $x y = 1$。

sol. 考虑 $S := {alpha := (a_n)_(n geq 1): "整数列"}$，定义 $S$ 上的加法为逐项相加。\
#tab 取 $R$ 为所有满足 $phi.alt(a + b) = phi.alt(a) + phi.alt(b)$ 的映射 $phi.alt: S to S$ 构成的集合。
$R$ 对加法 $(phi.alt + psi)(alpha) := phi.alt(alpha) + psi(alpha)$ 与函数合成运算成环，$1_R = "id"_S$\
#tab 取 $x in R$ 为平移映射 $(a_1, a_2, dotc) arrow.bar (a_2, a_3, dotc)$，再构造 $y_k in R$ 使得 $(b_n)_(n geq 1) := y_k(alpha)$ 满足
$ b_n = cases(a_(n - 1) quad &n geq 2, a_k quad &n = 1) $
