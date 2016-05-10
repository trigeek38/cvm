{% extends "admin_edit_widget_std.tpl" %}
{% block widget_title %}{_ Profile extensions _}{% endblock %}
{% block widget_show_minimized %}false{% endblock %}
{% block widget_id %}content-person-can-edit{% endblock %}

{% block widget_content %}

    {% with m.rsc[id] as r %}
    <div class="form-group row">
        <div class="col-lg-4 col-md-4">
            <label for="is_superuser">{_ Superuser? _}</label>
        </div>
        <div class="col-lg-8 col-md-8">
            <input type="checkbox" name="is_superuser" id="is_superuser" {% if r.is_superuser %} checked {% endif %} />
        </div>
    </div>
    <div class="form-group row">
        <div class="col-lg-4 col-md-4">
            <label for="can_edit">{_ Can Edit? _}</label>
        </div>
        <div class="col-lg-8 col-md-8">
            <input type="checkbox" name="can_edit" id="can_edit" {% if r.can_edit %} checked {% endif %} />
        </div>
    </div>
    <div class="form-group row">
        <div class="col-lg-4 col-md-4">
            <label for="can_edit">{_ Service _}</label>
        </div>
        <div class="col-lg-8 col-md-8">
                  <select class="form-control" id="service" name="service">
                    <option value="">--All--</option>
                    {% with m.search.paged[{query cat="service" sort='pivot_title' }] as services %}
                       {% for service in services %}
                           <option value={{ service }}
                               {% ifequal r.service service %} selected {% endifequal %}
                           >{{ service.title }}</option>
                       {% endfor %}
                    {% endwith %}
                  </select>
        </div>
    </div>
{% endwith %}
{% endblock %}

