/* packages */
#import "../../__Template/Typst-Template/Packages-for-Typst-Template.typ": *
#show: environment

/* abbrs */
#import "../../__Template/Typst-Template/Abbrs-for-Typst-Template.typ": *
#let proof = proof-template.with(prefix: [proof.]) // more recommended by GPT 5.6 Luna, and get ce when try to use set/show

#show figure.caption: it => {
    it.body
}

/* specific math abbr. */
#let def = [*Def*.]
#let prop = [*Prop*.]
#let cov = [*Cov*.]
#let thm = [*Thm*.]

#let LM = $cal(L)$ // linear map
#let dirsum = math.plus.o // direct sum

#let range = "range"
#let null = "null"

#let bij = $arrow.l.r.long^(1:1)$

// norm(u) => ||u||
#let orcom(u) = $#u^bot$ // orthogonal complement
#let dotpro(u, v) = $chevron #u, #v chevron.r$

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

#page(numbering: none)[
    #align(center + horizon)[

        #text(size: 80pt)[
            #set par(spacing: 40pt)
            
            Linear Algebra

            Done Right
        ]

        #v(1em)
        #text(size: 40pt)[
            1001
        ]

        #v(6em)
        #text(size: 20pt)[
            #datetime.today().display()
        ]
    ]
]
#counter(page).update(1)

#let prefixs = ("Chapter", "Section", "")
#set heading(numbering: (..arr) => { // type(arr) is argument; Or can also use numbly to replace all these stuffs !
    arr = arr.pos() // .pos() captures positional arguments

    if arr.len() == 1 {
        return [
            #set text(size: 三号)
            #prefixs.at(0)
            #numbering("1", arr.at(0))
        ]
    }
    if arr.len() == 2 {
        return [
            #set text(size: 三号)
            #numbering("1A", arr.at(0), arr.at(1))
        ]
    }
    if arr.len() == 3 {
        return [ // at most 3, since outline.depth = 3
            #set text(size: 三号)
            #numbering("1", arr.at(2))
        ]
    }
    return []
})

#set align(center)
#text(size: 四号)[
    #outline(
        title: [
            #v(0.5em)
            #text(size: 初号)[Contents]
            #v(1em)
        ],
        indent: n => n * 1em,
        depth: 4 // only Part, Chapter & Section will display
    )
]

#pagebreak()
#counter(page).update(1)
#set align(start)

#show heading: it => {
    let arr = counter(heading).get()
    
    if it.level == 1 {
        page()[
            #set align(center + horizon)
            #set text(size: 初号)

            #text()[ #prefixs.at(0) #numbering("1", arr.at(0)) ]
            #v(1em)
            #it.body
        ]
    }
    else if it.level == 2 {
        align(center)[
            #set text(size: 一号)
            #set par(spacing: 15pt)

            #text()[
                #numbering("1A", arr.at(0), arr.at(1))
                #(" ")
                #it.body
            ]

            #divider()
        ]
    }
    else if it.level == 3 [
        #set text(size: 小二)
        #text()[
            #numbering("1.", arr.at(2))
        ]
        #it.body
    ]
    else [
        #set text(size: 小三)
        #it.body
    ]
}

#counter(heading).update(5)
= Inner Product Spaces

== Inner Products and Norms

== Orthonormal Bases

== Orthogonal Complements

=== Orthogonal Complement

#def *Orthogonal Complement*

$U subset V$, *not necessary to be a subspace*, then the orthogonal complement of $U$ is the set of all vectors that are orthogonal to every vector in $U$
$ orcom(U) := {v in V: forall u in U, dotpro(u, v) = 0} $

e.g. 取 $V$ 为所有二维向量的集合，$U = {(1, 1)}$，则 $orcom(U)$ 为 $y = -x$ 上的所有向量。

#prop

#[
    #set enum(numbering: "a.")
    + #[
        $orcom(U)$ is a subspace of $V$.

        验证定义。
    ]

    + #[
        $orcom({0}) = V, en orcom(V) = {0}$

        前者显然，后者 $u != 0 imply dotpro(u, u) != 0 imply u in.not orcom(V)$
    ]
    + #[
        $U inter orcom(U) subset {0}$

        显然。不取等因为可以 $0 in.not U$
    ]
    + #[
        If subset $G subset H subset V$, then $orcom(H) subset orcom(G)$

        显然。
    ]
]

#prop A natural decomposition \
If $U subset V$ is *finite*-dimensional subspace, then
$ V = U dirsum orcom(U) $

#proof()[
    *rewrite using the orthogonal basis of $U$*

    Let ${e_m}$ be a orthogonal basis of $U$, consider
    $ v = underbrace(sum dotpro(v, e_i) e_i, u in U) en + en underbrace(v - sum dotpro(v, e_i) e_i, w) $
    Only need to prove $w in orcom(U)$, and thus only need to prove $dotpro(w, e_i) = 0$ for all $e_i$. Obviously.
]

#cov If $U subset V$ is finite-dimensional subspace, then  $dim orcom(U) = dim V - dim U$

#prop Orthogonal complement of orthogonal complement \
If $U subset V$ is a finite-dimensional subspace, then
$ U = orcom((orcom(U))) $
proof.
- #[
    $U subset orcom((orcom(U)))$: 
    by definition, $u in U imply dotpro(u, v) = 0 space forall v in orcom(U) imply u in orcom((orcom(U)))$
]
- #[
    $orcom((orcom(U))) subset U$: suppose $v in orcom((orcom(U)))$. Since $V = U dirsum orcom(U)$, then $v = u + w$ for some $u in U, w in orcom(U)$. From above $U subset orcom(orcom(U))$, so $u in orcom((orcom(U)))$. Therefore
    $ cases(
        reverse: #true,
        w = v - u &in orcom((orcom(U))),
        w &in orcom(U)
    ) imply w in orcom(U) inter orcom(orcom(U)) = {0} imply w = 0 imply v = u $
    Which leads to $v in U imply orcom((orcom(U))) subset U$.
]

#cov $U = V iff orcom(U) = {0}$

#divider()

#def *Orthogonal Projection* 正交投影

Let $U$ is a finite-dimensional subspace of $V$. The orthogonal projection of $V$ onto $U$ is the operator $P_U in LM(V)$:
$ P_U v = u en "iff" v = u + w, sp u in U, sp w in orcom(U)  $

$P_U$ 把 $v$ 拍到低维空间。

#prop Suppose $U$ is a finite-dimensional subspace of $V$.
#[
    #set enum(numbering: "a.")
    + #[
        $P_U in LM(V)$

        $P_U$ 定义本身不显式说明，逐一验证。
    ]

    + #[
        $forall u in U, med P_U (u) = u quad forall w in orcom(U), med P_U (w) = 0$

        显然。
    ]
    + #[
        $range P_U = U en null P_U = orcom(U)$

        显然。
    ]
    + #[
        $v - P_U (v) in orcom(U)$

        定义。
    ]
    + #[
        $P_U^2 = P_U$

        If $v = u + w$, then $P_U v = u$, $P_U (P_U v) = P_U u = u$ from above.
    ]
    + #[
        $forall v in V, en norm(P_U v) leq norm(v)$

        $norm(v)^2 = dotpro(u + w, u + w) = dotpro(u, u) + dotpro(w, w) + 2 dotpro(u, w) = norm(P_U u)^2 + dotpro(w, w)$
    ]
    + #[
        If ${e_m}$ is an orthogonal basis of $U$, then $forall v in V$,
        $ P_U v = sum dotpro(v, e_i) e_i $
        前文已用过。
    ]
]

#divider()

#thm Riesz Representation Theorem

Suppose $V$ is finite-dimensional. For each $v in V$, define $phi_v in V'$ by $ phi_v (u) := dotpro(u, v) quad forall u in V $
Then $v barto phi_v$ is a one-to-one function from $V$ onto $V'$. 双射

proof for surjective: a constructive proof.\
If $phi = 0$, then $phi = phi_0$. Thus assume $phi != phi_0$, hence $null phi != V$, which implies $orcom((null phi)) != {0}$. Take $w in orcom((null phi)) and w != 0$. (From the conclusion, we know actually $w parallel v$. Assume $w = k v$, then $norm(w)^2 = dotpro(k v, k v) = k dotpro(v, k v) = k  overline(k) norm(v)^2, med overline(phi(w)) = overline(dotpro(k v, v)) = dotpro(v, k v) = overline(k) norm(v)^2$) Let
$ v = overline(phi(w))/norm(w)^2 med w $
Take the norm of both sides, $norm(v) = abs(phi(w))/norm(w)$. Apply $phi$ to both sides gives $phi(v) = (overline(phi(w)) phi(w))/(norm(w)^2) = abs(phi(w))^2/norm(w)^2 = norm(v)^2 = dotpro(v, v)$. Now for each $u in V$, rewrite it as
$ u &= (u - phi(u)/phi(v) v) + phi(u)/phi(v) v $

$ &phi(u - phi(u)/phi(v) v) = phi(u) - phi(u)/phi(v) phi(v) = 0 \
&imply u - phi(u)/phi(v) v in null phi \
& imply^(v in orcom(null phi)) dotpro(u, v) = dotpro(phi(u)/phi(v) v, v) = phi(u)/phi(v) norm(v)^2 = phi(u) $

=== Minimization Problems

Given a linear map $T$, we want to solve $T x = y$. However, $T$ may not be invertible, and $y$ may not in $range T$.  With the help of orthogonal projection, we can still minimize $norm(T x - y)$.

#prop Minimizing distance to a subspace \
Suppose $U$ is a finite-dimensional subspace of $V$, $v in V$, $u in U$. Then
$ norm(v - P_U v) leq norm(v - u) $
The inequality is an equality iff $u = P_U v$.

#proof()[
    $v - P_U v in orcom(U)$, $P_U v - u in U$. Therefore
    $norm(v - P_U v)^2 leq norm(v - P_U v)^2 + norm(P_U v - u)^2 = norm(v - P_U v + P_U v - u)^2 = norm(v - u)^2$
]

#divider()

*Function Approximation*

任取一组正交基用于拟合。必须指定拟合的区间，以确定内积定义。
$ dotpro(f, g) &:= integral_l^r f(x) g(x) dif x \
min norm(f - g) &iff min integral_l^r (f - g)^2 dif x $

泰勒级数只保证邻域内精度，而此方法在完整定义域上最优。

- #[
    Power Series: need to do Gram-Schmidt procedure first
]
- #[
    Fourier Series
]

=== Pseudoinverse

最小化问题中把正交投影 $P_U y$ 当作 $T x = y$ 的解，在此基础上继续削 $T$ 而成为可逆映射，引出伪逆的概念。

#prop Restriction of a linear map to obtain a one-to-one and onto map \
Suppose $V$ is finite-dimensional and $T in LM(V, W)$. Then $T|_(orcom((null T)))$ is an injective map of $orcom((null T))$ onto $range T$.

#proof()[
    injective: To prove $T v = 0 iff v = 0$. If $v in orcom((null T)) and T v = 0$, then $v in (null T) inter orcom((null T)) imply v = 0$ \
    range is $range T$: Obviously $range T_(orcom((null T))) subset range T$. To prove $range T subset range T_(orcom((null T)))$, take $w in range T$, then there exists $T v = w$. Since $V = (null T) dirsum (orcom((null T)))$, then we can rewrite $v = x + y$, where $x in null T, med y in orcom((null T))$. Hence, $T|_(orcom((null T)))x = w$.
]

Therefore, $T|_(orcom((null T)))$ is invertible.

#def Pseudoinverse $T^dagger$ \
Suppose $V$ is finite-dimensional and $T in LM(V, W)$. The pseudoinverse $T^dagger in LM(W, V)$ of $T$ is a linear map from $W$ to $V$ defined by
$ T^dagger w med := med (T_orcom((null T)))^(-1) compose P_(range T) med w $

#figure(
    image("6C pseudoinverse.jpg"),
)
$range T bij V slash null T$，但 $w in T$ 对应的是 $null T$ 的平移。伪逆将 $w$ 对应到唯一的 $v in V$，并且（在内积的意义上）$v$ 不含任何 $null T$ 的多余信息。

#prop Suppose $V$ is finite-dimensional and $T in LM(V, W)$
#[
    #set enum(numbering: "a.")
    
    + #[
        If $T$ is invertible, then $T^dagger = T^(-1)$

        $null T = {0} imply orcom((null T)) = V$, $range T = W$. Thus $T|T_orcom((null T)) = T$ and $P_(range T)$ is the identity operator on $W$.
    ]

    + #[
        $T compose T^dagger = P_(range T): W to W$, which is the orthogonal projection of $W$ onto $range T$.
    ]
    + #[
        $T^dagger compose T = P_orcom((null T)): V to V$, which is the orthogonal projection of $V$ onto $orcom((null T))$.
    ]
]

#prop Pseudoinverse provides best approximate solution or best solution\
Suppose $V$ is finite-dimensional, $T in LM(V, W)$, $w in W$.
#[
    #set enum(numbering: "a.")
    + #[
        If $v in V$, then
        $ norm(T(T^dagger w) - w) leq norm(T v - w) $
        with equality iff $v in T^dagger w + null T$
    ]
    + #[
        If $v in T^dagger w + null T$, then
        $ norm(T^dagger w) leq norm(v) $
        with equality iff $v = T^dagger w$
    ]
]