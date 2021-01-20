---
title: Dunfermline West Blog
layout: default
bgcolor: "#FFF"
permalink: "/blog/"
---
<div class="row notices">
{% for post in site.posts %}
{% assign mod = forloop.index | modulo: 4 %}
<div class="col-sm-3 text-normal post-item {{ mod }}">
<img src='{% if post.thumb %}{{ site.url }}/{{ post.thumb }}{% else %}{{ site.url }}/{{ post.image }}{% endif %}' alt='{{ post.title }}' />
<h4><a href="{{ post.url }}">{{ post.title }}</a></h4>
<span class='date'>{{ post.date  | date_to_long_string }}</span>
{{ post.excerpt }}
<a href='{{ post.url }}' class="btn btn-xl btn-primary mt-4">Read more</a>
</div>
    
{% if mod == 0  %}
</div><div class="row notices">
{% endif %}    
{% endfor %}
</div>

<div class="row">
<div class="col-lg-12 text-normal">
<hr />
<p class='center'>
   <a href='/events/' class="btn btn-xl btn-primary mt-4 call2action">View our latest events</a>  <a href='/online/' class="btn btn-xl btn-primary mt-4 call2action">Ways to gather with us</a>
</p>
</div>
</div>