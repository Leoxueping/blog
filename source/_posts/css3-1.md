---
title: css3学习笔记(一)
date: 2016-10-02 20:27:37
tags: css3
---
css3学习笔记
<!--more-->
#### 1.常见伪类选择器
(1)`:first-child` `:last-child` `:first-letter` `:first-line` `:nth-child(n)` `:after` `:later`  `:only-child`
`:nth-last-child(n)` `:nth-child(odd)`
`:nth-child(even)`  
(2)`:nth-of-type(n)` `:nth-last-of-type(n)`  注意这个与`:nth-child(n)`的区别是这个会选择同类的元素进行计数,如以下代码：  
```html
<div>
  <p>p1</p>
  <h6>h1</h6>
  <p>p2</p>
  <h6>h2</h6>
  <p>p3</p>
  <h6>h3</h6>
</div>
```
如果用`p:nth-child(n)`会把`<h6>`标签一起计算进去，比如:`p:nth-child(2)`得到的是第一个`<h6>`标签，但用`nth-of-type(2)`就是第二个`<p>`标签  
(3)`nth-child(αn+β)`可实现循环使用样式  
若有如下列表：
```html
<ul>
  <li>列表项目</li>
  <li>列表项目</li>
  <li>列表项目</li>
  <li>列表项目</li>
  <li>列表项目</li>
  <li>列表项目</li>
</ul>

<style>
li:nth-child(3n+1){
    color: red;
}
li:nth-child(3n+1){
    color: blue;
}
li:nth-child(3n+1){
    color: yellow;
}
</style>
```
列表会以3个为一组文本颜色以红 蓝 黄 进行循环  
(4)UI状态伪类选择器：  
`:hover` `:active` `:focus` `:enabled` `:disabled`  `:read-only` `:read-write` `:checked ` `::selection`
`:default` `:indeterminate`
(5)四个基本的结构性伪类选择器:
:root   :not   :empty   :target
(6)通用兄弟元素选择器：`子元素~子元素之后的同级兄弟元素`,如`div~p`为与div同级且在div之后的所有p标签元素
(7)使用after before在页面中插入内容：  
可插入文字 图片等  还可编号如：
```html
<p>列表</p>
<p>列表</p>
<p>列表</p>
<p>列表</p>
<p>列表</p>

<style>
p:before{
		content: counter(myCounter,upper-alpha)'.';
}
p{
		counter-increment: myCounter
}
</style>
```
会在p标签前加上以大写字母排序的编号（编号还可嵌套）
#### 2. 文字与文体相关样式  
(1)`text-shadow`加阴影  
(2)文字换行`word-break:break-all`与`word-wrap:break-word`的区别：
前者是不管单词多长，只要这一行还没填满，就要填满，便会导致单词内换行；但后者是只有单词过长，一整行还不足以容纳整个单词时才会在单词内换行。  
(3)`@font-face`使用服务端字体或客户端字体
(4)`font-size-adjust`可实现换字体种类，但字的大小不变
#### 3.盒相关样式
(1)`inline-block`可代替`float`实现水平排列的列  
注意用这个方法会使**两列之间有间隙**，原因是在写代码时标签之间换行了，具体解决方法可看此[博客](http://www.zhangxinxu.com/wordpress/2012/04/inline-block-space-remove-%E5%8E%BB%E9%99%A4%E9%97%B4%E8%B7%9D/ "怎样去除标签间的间隙")  
(2)`inline-table`可实现在表格等块级标签两侧加文字，使其处于同一行  
(3)`overflow`有四种处理方式auto scroll hidden visible(与不设置时一样)  
`text-overflow`属性设为`hidden`时可使水平方向超出的文字后面有一个省略号  
(4)指定针对元素的宽高计算方法`box-sizing`三种值:`border-box` `padding-box` `content-box`
#### 4.与边框和背景相关样式
(1)`background-clip`指定背景的显示范围  
(2)`background-origin`指定背景**图像**的绘制起点  
(3)`background-size`指定背景图片大小
(4)在一个元素中显示多个背景图像用逗号隔开
(5)`border-image`是把图片裁剪为九宫格，四个角上的不变，然后把四条边上的进行拉伸(stretch)、重复(repeat)或平铺(round)，中央区域图像也会进行伸缩
#### 5.transform变形
 有四种变换方式，分别如下：  
 (1)`rotate()`旋转，参数为旋转角度  
 (2)`scale()`缩放，可指定两个参数，分别为垂直和水平方向的缩放倍率  
 (3)`translate()`移动，可指定两个参数，水平与垂直  
 (4)`skew()`倾斜，两参数，水平与垂直  
 (5) 注意**变换顺序会影响最后的状态，因为移动是沿着边的垂直方向进行的**  
 (6)使用`transform-origin`指定变形的基准点。如`transform-origin(left top)`
#### 6.Transitions过渡
(1)基本使用:`transition:property(对哪个属性进行平滑过渡) duration(用多长时间完成过渡) timing-function(用什么方法过渡)`  
(2)过渡多个属性值中间用逗号隔开
(3) 此方法的缺点是只能定义开始和结束的状态，动画进行时不能控制，所以有了后面的Animations
#### 7.Animations动画
(1)使用时先用`@keyframes name`定义关键帧集合然后通过`animation:name duration timing-function`等多个参数进行使用  
(2)若不用`:hover`等状态选择器，直接把动画写在元素标签内，则动画会在打开页面是进行，如网页淡入效果：
```css
@keyframes fadeIn{
			0%{
				opacity: 0;
			}
			100%{
				opacity: 1;
			}
		}
		body{
			animation: fadeIn 2s linear;
		}
```
(3)此外还有很多参数可自行查找API
