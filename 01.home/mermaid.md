# mermaid

Markdown - [mermaid](https://mermaid.js.org/intro/)

## flowchart

```mermaid
flowchart TD
    A --> B;
    A --> C;
    B --> D;
    C --> D;
```

## sequenceDiagram

> 1

```mermaid
sequenceDiagram
    Alice ->> John: Hello John, how are you?
#loop Healthcheck
#John->>John: Fight against hypochondria
#end
#Note right of John: Rational thoughts!
    John -->> Alice: Great!
    John ->> Bob: How about you?
    Bob -->> John: Jolly good!
```

> 2

```mermaid
sequenceDiagram
    Client ->> + Service: 发送请求
    rect rgb(191, 223, 255)
        Service ->> Service: 处理请求
        Service -->> Client: 发送响应
    end
```

## gantt

```mermaid
gantt
    section Section
        Completed: done, des1, 2014-01-06, 2014-01-08
        Active: active, des2, 2014-01-07, 3d
        Parallel 1: des3, after des1, 1d
        Parallel 2: des4, after des1, 1d
        Parallel 3: des5, after des3, 1d
        Parallel 4: des6, after des4, 1d
```

## classDiagram

```mermaid
classDiagram
    Class01 <|-- AveryLongClass: Cool
    <<Interface>> Class01
    Class09 --> C2: Where am i?
    Class09 --* C3
    Class09 --|> Class07
    Class07: equals()
    Class07: Object[] elementData
    Class01: size()
    Class01: int chimp
    Class01: int gorilla
    class Class10 {
        <<service>>
        int id
        size()
    }
```

## pie

```mermaid
pie showData
    title Key elements in Product X
    "Calcium": 40.50
    "Potassium": 45.5
    "Magnesium": 10
    "Iron": 5
```

## graph

```mermaid
graph TD
    start([开始]) --> 赋值arr[赋值arr]
    赋值arr --> 赋值len[len = arr.length]
    赋值len --> 赋值i[i = 0]
    赋值i --> 第一层循环{i < len}
    第一层循环 -- yes --> 赋值j[j = 1]
    赋值j --> 第二层循环{"j < len - i ?"}
    第二层循环 -- yes --> 判断{"arr[j - 1] < arr[j] ?"}
    判断 -- yes --> 定义临时变量["int temp = arr[j - 1]"]
    定义临时变量 --> 交换aj["arr[j - 1] = arr[j]"]
    交换aj --> 交换aj-1["arr[j] = temp"]
    交换aj-1 --> j自增["j++"]
    j自增 --> 第二层循环
    判断 -- no --> j自增
    第二层循环 -- no --> i自增["i++"]
    i自增 --> 第一层循环
    第一层循环 -- no --> endd([结束])
```

## erDiagram

```mermaid
erDiagram
    CUSTOMER
    ORDER
```

### 属性 (Attributes)

属性描述实体的特性，它紧跟在实体名称下方，并用一个冒号 : 分隔。属性可以带有类型和可选的键：

- 属性名 类型: 这是最基本的属性定义。
- 属性名 类型 `PK`: 表示主键 (Primary Key)。
- 属性名 类型 `FK`: 表示外键 (Foreign Key)。
- 属性名 类型 `UK`: 表示唯一键 (Unique Key)。

```mermaid
erDiagram
    CUSTOMER {
        string customerId PK
        string name
        string email UK
        int age
    }
    ORDER {
        string orderId PK
        string customerId FK
        date orderDate
        float totalAmount
    }
```

### 关系 (Relationships)

关系连接两个实体，描述它们之间的联系。Mermaid `erDiagram` 支持多种关系类型，每种类型都有对应的符号：

关系连接符：

- `--` : 无具体方向或默认关系。
- `--o` : 从左到右的开放箭头，通常表示“可以有”或“可选”。
- `o--` : 从右到左的开放箭头。
- `--|` : 从左到右的实心箭头，通常表示“必须有”或“一对一”。
- `|--` : 从右到左的实心箭头。

### 关系基数 (Cardinality)

基数表示一个实体实例与另一个实体实例关联的数量。它紧随在连接符之后，用以下符号表示：

- `|o--||`：一对一 (One to One)
- `|o--o{`：一对零个或一个 (One to Zero or One)
- `|o--|{`：一对一个或多个 (One to One or Many)
- `||--|{`：一对多个 (One to Many)
- `o{--o|`：零个或一个对一个 (Zero or One to One)
- `o{--o{`：零个或一个对零个或一个 (Zero or One to Zero or One)
- `o{--|{`：零个或一个对一个或多个 (Zero or One to One or Many)
- `|{--o|`：一个或多个对一个 (One or Many to One)
- `|{--o{`：一个或多个对零个或一个 (One or Many to Zero or One)
- `|{--|{`：一个或多个对一个或多个 (One or Many to One or Many)

### 关系名称

关系可以有一个描述性的名称，放在两个实体中间，用冒号 `:` 分隔。

```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER: has
    ORDER ||--|{ PRODUCT: contains
    PRODUCT }|--|| CATEGORY: belongs-to
```

### 完整示例

将上述概念结合起来，一个更完整的 `ER` 图示例

这个示例展示了客户下订单，订单包含产品，产品属于某个分类的场景

```mermaid
erDiagram
    CUSTOMER {
        string customerId PK
        string name
        string email UK
        int age
    }
    ORDER {
        string orderId PK
        string customerId FK
        date orderDate
        float totalAmount
    }
    PRODUCT {
        string productId PK
        string name
        float price
        int stockQuantity
    }
    CATEGORY {
        string categoryId PK
        string name
    }

    CUSTOMER ||--o{ ORDER: places
    ORDER ||--|{ PRODUCT: includes
    PRODUCT }|--|| CATEGORY: categorized-by
```
