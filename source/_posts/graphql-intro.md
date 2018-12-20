---
title: 初探GraphQL
date: 2018-12-20 19:39:38
tags: javascript
---
### 一、什么是 `GraphQL`
全称 `Graph Query Language`，是Facebook于2012年创造的一种用于 API 的查询语言，通俗地讲，就是相当于将你所有后端 API 组成的集合看成一个数据库，用户终端发送一个查询语句，你的 `GraphQL` 服务解析这条语句并通过一系列规则从你的“ API 数据库”里面将查询的数据结果返回给终端，而 `GraphQL` 就相当于这个系统的一个查询和定义语言。是一种与 `Rest` 完全的不同的 `API` 方案。
<!--more-->

### 二、核心概念
要了解 `GraphQL`，就需要先清楚它的几个核心概念
#### 1.`GraphQL schema language`
要定义 `GraphQL`，先要了解一个简单的语言，`GraphQL schema language`，它是用来定义你的 `GraphQL` 服务的，要使用它把你的所有资源和入口都描述出来。先来看下它的几个概念:
* `Type` (类型)   
  `Type` 是一种抽象数据模型，比如 `JavaScript` 中有 `number, string, boolean` 等数据类型，`GraphQL` 中的 `Type` 就是类似的概念。每一个 `GraphQL` 服务都要定义一套类型，以描述可查询到的数据，且每次查询都需要对类型进行验证，这样就避免了一些未知的 `bug`，以下就是一个简单的例子:
  ```javascript
  type Author {
    name: String!,
    posts: [Post]!
  }
  ```
  上面的代码就定义了一个名为 `Author` 的对象类型，它有两个字段 `name` 和 `posts`，`name` 是一个非空的 `String` 类型的字段，`posts` 是一个 `Post` 类型的列表。  
  `GraphQL` 中的类型分为 `Scalar` (标量类型)和  `Object` (对象类型)。
  * 内置的标量类型有 `String, Int, Float, Boolean, ID`，其中 `ID` 表示一个不可重复的值，跟数据库中的 `id` 差不多意思，在 `JavaScript` 中是一个字符串。
  * 对象类型是由一些字段组成的复杂数据类型，比如上面的 `Person` 就是一个对象类型，是由我们定义的。
  * 除了以上两种类型，还有类型修饰符，`!` 代表非空，比如上面的 `name` 字段后面加了 `!`，表示你每次查询 `name` 字段的时候必定会返回一个非空的值。
  *  还有一种稍微特殊一点的对象类型，叫 `input`，输入类型，一般这样定义:
    ```javascript
    input PersonInput {
      name: String,
      Post: String
    }
    ```
    它只是把 `type` 关键字换成了 `input` 关键字，代表用户输入，如果你想传入一个非标量的参数，就需要定义对应的输入类型。
  * 另外，还有其他的类型: `Emun`--枚举类型，`Union`--联合类型，`interface`--接口，概念都和编程语言中的差不多。
* Schema
  `Schema` 描述了数据的组织形态以及服务器上有哪些字段能被查询，以及如何查询，由上面介绍的各种类型的字段组成，当查询到来时，服务器会根据你定义的 `Schema` 对查询进行验证，通过之后才会执行查询。
* Root Type (Query Type)  
  根类型，代表着你的服务的入口，一个服务至少定义一个根类型，不然是没法查询。注意，这个根类型除了是入口之外跟其他的对象类型的字段并没有其他的区别。可以定义三种入口：
  * Query: 查询，用来定义查询的入口。这里 `Query` 和上面的根类型 `Query Type` 不是一个概念，所以把上面的叫做 `Root Type` 没有这么容易混淆。
  * Mutation: 突变，用来定义改变数据的入口。
  * Subscription: 订阅，定义订阅事件的入口，注意，它是用来定义事件的，比如当某一个 `mutation` 执行时通知客户端。
  
了解了上面的概念之后，可以去看看[例子](https://github.com/lixpng/graphql-demo/blob/master/src/schema.js)。

#### 2.resolver  
上面我们了解了如何定义一个 `Schema`，但并没有说如何返回数据，所以下面就要了解一个叫做 `resolver` (解析器)的东西，它是用来解析字段并返回字段的值的。它就是个普通的函数，如:
```javascript
function getAuthor(obj, params, ctx, info) {
  return {
    name: 'author1',
    age: 19
  }
}
```
它接受四个参数：
* `obj`，上一级对象，因为 `GraphQL` 是逐层解析字段的，所以一般会有上一级对象传入。
* `params`，我们查询时传入的参数变量
* `ctx`，可以传给所有解析器的上下文，可以在这里传入 `request` 对象和数据库连接对象等。
* `info`，是关于查询的字段的特定信息和 `Schema` 的信息。

#### 3.GraphQL query language
将上面的 `Scheam` 和 `resolver` 进行组合(如何组合就是看各个框架的实现方式了)，就能启动一个 `GraphQL` 服务了。具体可以看[Demo](https://github.com/lixpng/graphql-demo)。但是如何对它进行查询呢，就需要通过一个叫 `GraphQL query language` 的简单语言。如:
```javascript
query getAuthors($option: AuthorInput) {
  allAuthors(option: $option) {
    id
    name
    age
    posts{
      id
      title
      content
    }
  }
}
```
上面就是一个简单的查询文档，可以运行了[Demo](https://github.com/lixpng/graphql-demo)之后进行查询尝试。  
它有以下几个概念：  
* 操作类型，就是例子中的 `query`，其他的类型还有 `mutation` 和 `subscription` 。
* 操作名称，当有多个查询文档时，必须定义操作名，上面例子中时 `getAuthors`。
* 变量，变量类型，和参数：在 `GraphQL query language` 中，可以通过外部传入变量，最后会把参数用你传入的变量进行替换来进行查询，但变量名必须以 `$` 符号开头，且必须指定变量类型。如上面例子中的 `$option` 就是变量，类型是 `AuthorInput`，参数是 `option`。
* 要使用的查询：就是使用入口中的哪个字段，比如上面例子中是查询了 `allAuthors`。
* 查询的字段：再就是你想要查询的字段，对象类型的字段必须展开。  
  
了解了以上概念，并把[Demo](https://github.com/lixpng/graphql-demo)跑一遍应该就对 `GraphQL` 有一个大概了了解了。

### 三、总结
`GraphQL` 使用强类型系统定义服务，保证了参数的类型正确，自带的交互式在线调试器提供友好的调试界面，强大的自省系统使得它代码即文档，能大大降低前后端的沟通成本，而且单一入口使得后端无需再做繁琐的版本维护，前端想要什么数据完全可按需请求，避免了数据冗余；当然也可能会碰到一些问题如 `n+1` 问题等，不过官方和社区都有提供可行的解决方案。总之，它是一个能让前端爽的API方案，所以有机会可以试一下。