---
title: CSS3学习笔记(二)
date: 2016-10-03 20:02:04
tags: css
---
css3学习笔记
<!--more-->
#### 1.多栏布局
  首先先说说用`float`和`position`布局的缺点：就是在布局时水平排列的div是互相独立的，即如果两个div的内容的高度不一样，两个div的底部不能对齐，导致页面中出现空白；其次，float的消除浮动也比较烦。css3中的多栏布局决解了这些问题。  
  使用`column-count`可使元素中的内容分栏显示,不会出现底部不对齐的情况  
  `column-width`可指定每一栏的宽度(个人觉得一般不用，指定总宽度即可)，但宽度都是一样的  
  `column-gap`可指定每栏间的间隔     
  `column-rule`可在栏与栏之间增加一条间隔线，其语法与border的语法一样
#### 2.盒布局
  盒布局也是解决`float`和`position`布局缺点的方法，但比多栏布局更适合用于整体布局。因为多栏布局的每一栏的宽度是一样的，故很难用于整体布局，一般用于文章的分栏显示。但盒布局就解决了这个问题。  
  给容器设置`display:box`,就可实现分栏显示了。
  ```html
  <div style="width:1000px" class="container">
    <div class="div1">
      文本1
    </div>
    <div class="div2">
      文本2
    </div>
    <div class="div3">
      文本3
    </div>
  </div>
  .container{
    display: box;
  }
  ```
  以上代码中的三个子div便会分栏显示，但它们的总宽度并不等于container的宽度。此时就需要弹性盒布局了。如果给第二个子div增加样式：
  ```css
  .container{
    display: box;
  }
  .div2{
    box-flex:1;
  }
  ```
  此div即会弹性伸缩宽度，其宽度等于容器的宽度减去div1和div3的宽度。也可指定多个div的box-flex属性。  
  box-flex属性的值代表的是其占的空白宽度，即先把容器的宽度减去div1 div2 div3 的宽度得到空白的宽度，再将其按比率分给设定了box-flex的div。  
  弹性布局可改变元素的显示顺序，通过设置元素的`box-ordinal-group`，如：
  ```css
  .container{
    display: box;
  }
  .div1{
    box-ordinal-group:3
  }
  .div2{
    box-ordinal-group:1
  }
  .div3{
    box-ordinal-group:2
  }
  ```
  结果是div2在左边，div3居中，div1在右边  
  弹性布局可改变元素的排列顺序，通过设置`box-orient`属性的值为`vertical`(垂直)或`horizontal`(水平)  
  还可通过设置box-pack box-align改变子元素的对齐方式  
  以上说的css3中属性或值要加上-webkit-  -moz-  -o-  前缀，且这是2009年草案的语法。
