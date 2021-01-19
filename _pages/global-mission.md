---
seotitle: Dunfermline West Global Mission
title: Global Mission
layout: services
permalink: "/global-mission/"
---

<div class="row">
<div class="col-sm-8">
    
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/maps.js"></script>
<script src="https://cdn.amcharts.com/lib/4/geodata/worldLow.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<div id="chartdiv"></div>

<script>
var countries = '{% for mission in site.missions %}{{ mission.country }},{% endfor %}';
</script>
<script src="{{site.url}}/assets/world-map.js"></script>

</div>
<div class="col-sm-4 text-normal">
### We support
<p>(Click the name to see which areas they have worked in recently)</p>
<ul>
{% assign missions = site.missions | sort: 'date' | reverse %}
{% for mission in missions %}
<li class="maphover" ref='{{ mission.country }}'>{{ mission.title }}</li>
{% endfor %}    
</ul>   
</div>
</div>

<div class='row'><div class="col-sm-12">
Over the years the fellowship at Dunfermline West Baptist has supported various missions and charities. This is just to give you an overview of what they do and how we contribute to their work. Hopefully it will be informative and encouraging. You can find more information on their websites but if we have up-to-date news this will be shared each month.
</div></div>

<div class="row notices">

{% for mission in missions %}
{% assign mod = forloop.index | modulo: 3 %}
<div class="col-sm-4 text-normal">
<h4>{{ mission.title }}</h4>
[{{ mission.link }}]({{ mission.link }})
<br /><span class='date'>{{ mission.date  | date_to_long_string }}</span>
{{ mission.excerpt }}
{% if mission.excerpt != mission.content %}
<button class="btn btn-xl btn-primary mt-4" data-toggle="collapse" data-target="#mission{{ forloop.index }}" aria-expanded="false" aria-controls="mission{{ forloop.index }}">Read latest update</button>
<div class='collapse multi-collape' id='mission{{ forloop.index }}'>
{{ mission.content  | remove_first:mission.excerpt }}
</div>
{% endif %}
</div>
    
{% if mod == 0  %}
</div><div class="row notices">
{% endif %}    
{% endfor %}
</div>

<div class='row'>
<div class="col-sm-12">
### Generosity
We would like to thank all of you for your generosity in continuing to give to the church, and the charities it supports, during this time. We appreciate that these are uncertain times and are grateful that many of us are still able to contribute to the mission of the Church. 

You can find further information on how to give to the church via bacs (preferred), cheque or cash at: [https://dwb.church/giving/](https://dwb.church/giving/)
</div>
</div>
