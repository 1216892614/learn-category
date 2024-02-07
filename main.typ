#import "lib.typ": *

#show: project.with(
  title: "Learn Category",
  authors: (
    (name: "HuNerd", email: "hndppt@outlook.com"),
  ),
  date: [#datetime.today().display("[year]-[month]-[day]")],
)

= 什么是猫猫

*对象*(Object)的*身份*(Identity)总是不平凡的(Extraordinary), 在经过*抽象*(Abstraction)后抹除细节会变的相对平凡(Ordinary). 在*组合*(Composition)中细节往往是无关紧要的, 经过抽象后的平凡对象往往意味着可以在组合中被任意替换. 猫猫论(Category Theory)的核心是关于身份和组合. 这是一种认识论(Epistemology)而非本体论(Ontology), 前者是我们认识世界的思维方式, 后者是世界本身的真理.

#align(center)[
  #commutative-diagram(
    node((0, 0), $"Obj" a$, "x"),
    node((0, 1), $"Obj" b$, "y"),
    arr("x", "y", $"Mor" f_1$, curve: 20deg),
    arr("x", "y", $"Mor" f_2$, label-pos: right, curve: -20deg),
  )

  $ "Cat" X $
]

- *范畴, 猫猫*(Category, Cat)

- *对象*(Object, Obj): 组成猫猫的元素之一, 用点$dot a$表示, 不存在更多细节._(\*在实际交换图中我们会省略点$dot$的存在)_

- *态射*(Morphisms, Mor): 组成猫猫的元素之一, 连接对象与对象, 有向, 用箭头$a arrow b$表示. 对同样的对象序列可以存在*任意多*的态射, 它们不相等, 态射是不平凡的.

== 组合与身份(Composition and Identity)

#pad(top: 5pt)[#align(center)[#commutative-diagram(
  node((0, 0), $a$, "a"),
  node((0, 1), $b$, "b"),
  node((0, 2), $c$, "c"),
  arr("a", "b", $f$, label-pos: right),
  arr("b", "c", $g$, label-pos: right),
  arr("a", "c", $g circle.tiny f$, curve: 20deg),
)]]

#align(center)[
  $forall "Mor" f: a->b, g: b->c, exists "Mor" g circle.tiny f: a -> c$
]

- *组合*(Composition): 当我们有 $f: a -> b, g: b -> c$ 的时候我们总有 $g circle.tiny f: a -> c$, 其中 $g circle.tiny f$ 读作 _g after f_.

#pad(top: 5pt)[#align(center)[#commutative-diagram(
  node((0, 0), $a$, "a"),
  arr("a", "a", pad(bottom: 15pt)[$"id"_a$], curve: 70deg),
)]]

#align(center)[
  $forall "Obj" a, exists "id"_a: a -> a$
]

- *身份*(Identity): 对于猫猫中的每一对象, 都有一个指向自身的态射, 称为*身份*.

#pad(top: 5pt)[#align(center)[#commutative-diagram(
  node((0, 0), $a$, "a"),
  node((0, 1), $b$, "b"),
  arr("a", "b", $f$, label-pos: right),
  arr("b", "b", pad(bottom: 15pt)[$"id"_b$], curve: 70deg),
)]]

#align(center)[
  $forall "Mor" f: a -> b, exists "id"_b circle.tiny f = f$
]

*定理: *因此我们总是可以从一个态射$f$出发可以获得与其终点对象身份组合的态射$"id"_b circle.tiny f $, 也就是$f$本身. _(\*注意, 这两个态射同时存在的时候并不恒等$eq.triple$, 它们仅仅是相同的组合形式, 态射是不平凡的, 下文的定理也是相同的)_

#pad(top: 5pt)[#align(center)[#commutative-diagram(
  node((0, 0), $a$, "a"),
  node((0, 1), $b$, "b"),
  arr("a", "b", $g$, label-pos: right),
  arr("a", "a", pad(bottom: 15pt)[$"id"_a$], curve: 70deg),
)]]

#align(center)[
  $forall "Mor" g: a -> b, exists g circle.tiny "id"_a = g$
]

*定理: *我们也总可以从一个对象$a$出发获得与其相连态射组合$ g circle.tiny "id"_a$, 也就是$g$本身.

== 组合性和同一性(Composability and Identity)

#pad(y: 40pt)[#align(center)[#commutative-diagram(
  node((0, 0), $a$, "a"),
  node((0, 1), $b$, "b"),
  node((0, 2), $c$, "c"),
  node((0, 3), $d$, "d"),

  arr("a", "b", $f$),
  arr("b", "c", $g$),
  arr("c", "d", $h$),

  arr("a", "c", $g circle.tiny f$, curve: 25deg),
  arr("a", "d", $h circle.tiny (g circle.tiny f)$, curve: 40deg),

  arr("b", "d", $h circle.tiny g$, label-pos: right, curve: -25deg),
  arr("a", "d", $(h circle.tiny g) circle.tiny f$, label-pos: right, curve: -40deg),
)]]

#align(center)[
  $forall "Mor" f: a -> b, g: b -> c, h: c -> d, exists h circle.tiny (g circle.tiny f) = (h circle.tiny g) circle.tiny f$
]

*定理: *对任意态射$f, g, h$, 态射满足结合律. 即运算顺序为$h circle.tiny (g circle.tiny f)$和运算顺序为$(h circle.tiny g) circle.tiny f$结果是一样的. _(\*依旧注意, 这两个态射同时存在的时候并不恒等$eq.triple$, 它们仅仅是相同的组合形式.)_

我们可以尝试在编程中探索这些概念, 下面是一些一一对应关系的概念作为参考:

- $"对象" <==> "类型"$: 你可以将类型看作一组值的集合
- $"态射" <==> "函数"$: 那么在PL类型模型中, 函数(纯函数)在数学中仍旧是函数(数学函数), 只不过是对值集合的函数, 接受一个集合, 返回一个集合

```hs
f1::X->Y
f1 x = y

f2::Y->Z
f1 y = z

f2_after_f1::X->Z
f2_after_f1 x = (f2 . f1) x

-- 这里 assert_eq 中 lambda 的 in 在理想情况下代表任意合法值
-- 当且仅当这两个 lambda 返回值相同时断言成立
assert_eq (\in -> f2 (f1 in)) (\in -> f2_after_f1 in)
```

从上文的(伪)Haskell代码中我们可以看到交换律的组合关系.

#align(center)[#box(width: 30%)[#render(```
   .---f2_after_f1---.
  _|__    _____    __|_ 
 /    \  /     \  /  V \
 | . -|--|->. -|--|->. |
 | . -|--|->. -|--|->. |
 | . -|--|->. -|--|->. |
  \__/    \___/    \__/ 
       f1       f2
   X  --->  Y  --->  Z
```)]]

如你所见, 态射和对象组成的交换图隐藏了数据的实质内容, 但是通过数据之间的联系我们可以看到足够多的东西来推断. 在这种意义上, 猫猫是抽象数据结构的终点, 猫猫是展示数据联系的终点.

#pagebreak()

= 函数, 泛态(Functions, epimorphisms)

普遍来说, 计算机语言是由语义构成的, 其中一种是告诉你程序的操作流程, 被称为*操作语义*(Operational Semantics); 另一种是将程序映射到另一领域的模型, 这被称为*指称语义*(Denominational Semantics).

尽管我们在编程中也有函数, 但是它们和数学中的函数概念并不同一. 因此我们有了*纯函数*(Pure Function)和*总函数*(Total Function)的概念.

#align(center)[#box(width: 65%)[#render(```
            ^^
        \\ //
         \\/                        \ |
        +---+                        \| -+
      --|---|-->                   ---*--|-->
      --|---|-->                     | \-|-->
      --|---|-->                     |  ++-->
      --|---|-->                   --|---|-->
        +---+                        +---+

    Pure Function             Not Pure Function
    纯粹的输入输出            相同的输入也不一定代表相同
    不受外界影响              的输出, 输出受外界副作用影响

        +---+                        +---+
      --|---|-->                   --|---|-->
      --|---|-->                   --|-| |
      --|---|-->                   --|---|-->
      --|---|-->                   --|-| |
        +---+                        +---+

    Total Function                Total Function
    对每种合法输入                在部分输入会
    都有结果                      有未定义的值

```)]]

- *纯函数*(Pure Function): 一个纯函数是指它的输出只依赖于其输入参数, 并且在执行过程中不产生或受到外部世界的任何副作用. 这意味着给定相同的输入, 纯函数总是返回相同的输出, 并且单独的它不会修改任何外部状态 (如全局变量) 或执行其他有副作用的操作 (如写入文件、更改数据库等). _(\*尽管我们现在这样说, 但是在后面我们会想办法用纯函数实现这一切的.)_
- *总函数*(Total Function): 在计算理论中, 总函数是指对于其定义域内的每一个输入值, 函数都能给出一个输出值的函数. 这与*部分函数*(Partial Function)相对, 部分函数可能对某些输入没有定义输出.

#align(center)[#box(width: 35%)[#render(```
  ____                    _____ 
 /    \                  /     \
 | . -|------------------|->.  |
 | . -|----------+-------|->.  |
 | . -|---------/        |     |
 | . -|--------+         |     |
 | . -|------------------|->.  |
 | . -|----+-------------|->.  |
 | . -|----+             |     |
  \__/                    \___/ 

  Domain -- Function ->  Codomain
```)]]

在一个函数映射中, 你可以将多个输入映射到一个输出, 但是反之将多个输出映射到一个输入是绝对不行的, 这就是函数的*方向性*(Directionality)来源, 也是为何*总纯函数*(Total Pure Function)的表示是一个箭头. 在总纯函数中我们会定义:

- *领域*(Domain): 也就是包含所有函数有效输入的集合.
- *共域*(Codomain): 也就是包含所有函数可能的输出的集合.
- *图像*(Image): 这个函数映射向的结果集合_(\*共域往往是这个结果的子集)_.

函数的方向性是一个很重要的猫猫论直觉, 在之后我们还会看到其他东西之间的映射关系, 比如: 猫猫之前的映射关系, 我们称之为*函子*(Functor); 还有函子之间的映射关系, 我们称之为*自然变换*(Natural Transformation)...而这些映射都具有类似的方向性.

#align(center)[#grid(
  columns: (auto, auto),
  rows: (auto, auto),
  rect(width: 100%, height: 130pt, stroke: (right: 1pt, left: 1pt, top: 1pt, bottom: 0pt))[
    #render(```
      ____                    _____
     /    \                  /     \
     | . -|------------------|->.  |
     | . -|------------------|->.  |
     |    |                  |     |
     | +--+---- g -----------+--+  |
     | |  |                  |  |  |
     | v  |                  |  |  |
     |x. -|---- f -----------|->.y |
      \__/                    \___/
    
     Domain ------ f ------> Codomain
    ```)
  ],

  rect(width: 100%, height: 130pt, stroke: (right: 1pt, left: 1pt, top: 1pt, bottom: 0pt))[
    #pad(top: 35pt)[#commutative-diagram(
      node((0, 0), $a$, "a"),
      node((0, 1), $b$, "b"),
      arr("a", "b", $f$, curve: 20deg),
      arr("b", "a", $g$, curve: 20deg),
      arr("b", "b", pad(bottom: 15pt)[$"id"_b$], curve: 70deg),
      arr("a", "a", pad(top: 15pt)[$"id"_b$], label-pos: right, curve: -70deg),
    )]
  ],

  rect(width: 100%, height: 40pt, stroke: (right: 1pt, left: 1pt, top: 0pt, bottom: 1pt))[
    ```hs
    f::a->b
    g::b->a
    ```
  ],

  rect(width: 100%, height: 40pt, stroke: (right: 1pt, left: 1pt, top: 0pt, bottom: 1pt))[
    $g circle.tiny f = id_a$

    $f circle.tiny g = id_b$
  ]
)]

既然有方向性, 那么我们就会考虑可逆问题. 既然我们可以从一个函数的领域映射到其共域, 那么我们能否从其共域以相反的关系映射到其领域来得到*逆函数*(Inverse of the Function)?

- *可逆函数*(Inverse of the Function): 从其对应函数的领域中任何一个元素在共域的映射出发映射回原本领域中原来元素也可以组成函数.
- *函数同构*(Isomorphism Between Functions): 一个函数和其逆函数之间的关系.

同样我们可以将这层关系延申到猫猫上:

- *逆态射*(Inverse of the Morphism): 从其对应态射的目标指向起始的态射.
- *同构*(Isomorphism): 一个态射和其逆态射之间的关卡.

我们来讨论一下有哪些函数不能成为可逆函数:


#align(center)[#grid(
  columns: (130pt, 130pt),
  rect(width: 130pt, height: 80pt, stroke: (right: 1pt, left: 1pt, top: 1pt, bottom: 0pt))[
    #render(```
     ____      _____ 
    /    \ f  /     \
    | . -|--+-|->.  |
    | . -|--+ |     |
     \__/      \___/ 
    ```)
  ],

  rect(width: 130pt, height: 80pt, stroke: (right: 1pt, left: 1pt, top: 1pt, bottom: 0pt))[
    #render(```
             ________
    ____    | .____ .|
   /    \ f | /    \ |
   | . -|---++->.  |.|
   | . -|---++->.  | |
    \__/    |.\___/. |
            |________|
    ```)
  ],

  rect(width: 130pt, height: 20pt, stroke: (right: 1pt, left: 1pt, top: 0pt, bottom: 1pt))[函数会折叠元素],

  rect(width: 130pt, height: 20pt, stroke: (right: 1pt, left: 1pt, top: 0pt, bottom: 1pt))[图像是共域的真子集],
)]

- 函数会折叠元素, 这意味着函数的领域中的多个元素映射向共域中的同一个元素.
- 图像是共域的真子集, 函数的输出无法覆盖它所有可能的输出集合.

针对这两种情况我们有了以下概念:

#align(center)[#box(width: 35%)[#render(```
  ____                    _____ 
 /    \                  /     \
 |x1.-|------------------|->.y1|
 |x2.-|------------------|->.y2|
 |x3.-|------------------|->.y3|
  \__/                    \___/ 

    -- Injective Function -->
```)]]

- *单射*(Injective), *注入*(Injection): 指一个不折叠元素, 领域和共域一一映射的函数.

#align(center)[#box(width: 35%)[#render(```
                          ________
 ____                    |xx____xx|
/    \                   |x/    \x|
| . -|-------------------++->.  |x|
| . -|-------------------++->.  |x|
 \__/                    |x\___/xx|
                         |________|

    -- Surjective Function -->
```)]]

#align(center)[
  $forall y, exists x, y = f(x)$
]

- *满射*(Surjective): 指共域完全覆盖它的图像, 函数的输出完全覆盖它所有可能的输出集合.

只有当一个函数同时满足*单射*和*满射*的时候它才是一个可逆函数. 既然我们可以在函数中得到这样的函数特征, 那么我们当然可以抽象这种特征到范畴论中, 下面我们先谈论满射的对应*泛态*:

#pad(top: 5pt)[#align(center)[#commutative-diagram(
  node((0, 0), $a$, "a"),
  node((0, 1), $b$, "b"),
  node((0, 2), $c$, "c"),
  arr("a", "b", $f$),
  arr("b", "c", $g_1$, curve: 20deg),
  arr("b", "c", $g_2$, label-pos: right, curve: -20deg),
)]]

#align(center)[
  $forall c, forall g_1, g_2 :: b -> c, g_1 circle.tiny f = g_2 circle.tiny f => g_1 = g_2$
]

- *泛态*, *外态*(Epic, Epimorphism): 对对象$b$和所有从$b$指出的态射指向对象$c$的所有态射$g$, 其中的每一$g_1$, $g_2$都与从$a$指向$b$的态射$f$满足$g_1 circle.tiny f = g_2 circle.tiny f$, 也即$g_1 = g_2$, 则态射$f$满足泛态. 这对应函数中的满射概念.

#align(center)[
  $forall a, b, c, a circle.tiny c = b circle.tiny c => a = b$
]

这也揭示了猫猫运算的另一项准则: 你可以化简等式两侧相同的组合运算.

== 单态, 简单类型(Monomorphisms, simple types)

和向$a -> b$后组合一个$c$不同, 在这里我们需要向前组合一个$c$来定义单态, 而且我们要先讨论否定的情况.


#align(center)[#box(width: 30%)[#render(```
  ____    _____    ____ 
 /    \  /     \  /    \
 |    |g1|  x1 |  |  y |
 |z. -++-|->. -++-|->. |
 |    |+-|->. -++ |    |
  \__/ g2 \_x2/    \__/ 
       g        f
   c  --->  a  --->  b
```)]]

从上图我们可以看到一个典型的非单射情况, 来自$a$外部的集合$c$中的点指向$a$中的态射和态射$f:a->b$组合就可能会产生相同的态射, 即$f circle.tiny g_1 != f circle.tiny g_2$, 也即$g_1 != g_2$. 将这个情况反向推广我们就可以得到单射的定义:

#pad(top: 5pt)[#align(center)[#commutative-diagram(
  node((0, 0), $a$, "a"),
  node((0, 1), $b$, "b"),
  node((0, -1), $c$, "c"),
  arr("a", "b", $f$),
  arr("c", "a", $g_1$, curve: 20deg),
  arr("c", "a", $g_2$, label-pos: right, curve: -20deg),
)]]

#align(center)[
  $forall c, forall g_1, g_2 :: c -> a, f circle.tiny g_1 = f circle.tiny g_2 => g_1 = g_2$
]

- *单态*(Monic, Monomorphism): 对对象$a$和所有指向$a$态射发出的对象$c$的所有态射$g$, 其中的每一$g_1$, $g_2$都与从$a$指向$b$的态射$f$满足$f circle.tiny g_1 = f circle.tiny g_2$, 也即$g_1 = g_2$, 则态射$f$满足单态. 这对应函数中的单射概念.

_\*需要注意, 即便你的某个态射*既是单态又是泛态*, 它依旧有可能*不是同构的*, 这会在后面提到!!!_
