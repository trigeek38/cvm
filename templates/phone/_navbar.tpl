{# navbar for phone+ #}
<nav class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container-fluid">
        <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </a>

        <a class="brand" href="/"><img src="/lib/images/logo.png" class="logo" alt=""> {{ m.config.site.title.value }}</a>
        <div class="nav-collapse">
          <ul class="nav">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Go To ... <i class=" icon-caret-down"></i></a>
              <ul class="dropdown-menu">
                <li><a href="{% url chitchat %}">Chat Room</a></li>
                <li><a href="#">Action2</a></li>
              </ul>
            </li>
            <li class="divider-vertical"></li>
          </ul>
            <form class="navbar-search pull-right" method="get" action="{% url search %}">
              <input type="text" class="search-query" placeholder="Search" name="qs"/>
            </form>
			<div class="pull-right">
                {% include "_navbar_right.tpl"%}
            </div>        
			{% menu menu_id=menu_id id=id maxdepth=2 %}
        </div>
    </div>
  </div>
</nav>
