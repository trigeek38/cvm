{% extends "endo_base.tpl" %}

{% block content %}

{% with m.acl.user as user %}

  {% ifnotequal user id %}
    <div class="jumbotron">
      <p> Access Restricted </p>
    </div>
  {% else %}
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Information</h3>
      </div>
      <div class="panel-body">
        <p>Name: {{m.rsc[id].name_first}} {{id.name_surname}}</p>
        <p>Email: {{id.email}}</p>
        <p>Logins: {{ id.login_count }} </p>
        <p>Superuser: {{ id.is_superuser|yesno:"yes, no" }} </p>
        <p>Can Edit: {{ id.can_edit }} </p>
        <p>My Default Service: <span id="service_title">
           {% if m.rsc[user].service %}
               {{ m.rsc[user.service].title }}
           {% else %}
               All
           {% endif %}
        </span>&nbsp;&nbsp; <button id="change_service" class="btn btn-xs btn-default">Change My Default Service</button> </p>
        {% wire id="change_service" action={dialog_open title="Update Your Service" template="_update_service.tpl" id=id} %}
      </div>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title">Favorite Studies</h3>
      </div>
      <div class="panel-body">
      </div>
    </div>
  {% endifnotequal %}

{% endwith %}

{% endblock %} 
