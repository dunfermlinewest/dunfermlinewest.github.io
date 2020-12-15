---
title: Dunfermline West Notices
layout: default
bgcolor: "#FFF"
permalink: "/notices/"
---

<div class="row notices">
{% for notice in site.notices %}
{% assign mod = forloop.index | modulo: 4 %}
<div class="col-sm-3 text-normal {{ mod }}">
<h4>{{ notice.title }}</h4>
{{ notice.content }}
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