 <form id="update_service" name="update_service" class="form-horizontal" role="form" action="postback" method=POST>
   <div class="form-group">
     <label for="inputService" class="col-sm-3 control-label">Select A Service</label>
     <div class="col-sm-8">
       <select id="service" name="service" class="form-control">
          <option value="all">--All--</option>
             {% for service in m.search[{ query cat="service" sort="pivot_title" }] %}
               <option value="{{service.id}}" 
               {% ifequal id.service service.id %} selected {% endifequal %}
               >{{service.title}}
              </option>
             {% endfor %}
       </select>
     </div>
   </div>
   <div class="modal-footer">
   <button type="submit" class="btn btn-primary">Save</button>
   <button type="submit" class="btn" data-dismiss="modal">Cancel</button>
 </form>
      {% wire id="update_service" type="submit" postback={update_service id=id} delegate="mod_endo"  %}

