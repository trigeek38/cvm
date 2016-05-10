%% @author 
%% @copyright 2013 
%% Generated on 2013-11-19
%% @doc This site was based on the 'empty' skeleton.

%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%% 
%%     http://www.apache.org/licenses/LICENSE-2.0
%% 
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(cvm).
-author("").

-mod_title("EndoView").
-mod_description("College of Vet Med Endoscopy website.").
-mod_prio(10).

-include_lib("zotonic.hrl").

-export([observe_logon_submit/2, add_user/2, get_user_props/1]).

%%====================================================================
%% support functions go here
%%====================================================================

observe_logon_submit(#logon_submit{query_args=Args}, Context) ->
    Username = proplists:get_value("username", Args),
    Password = proplists:get_value("password", Args),
    case Username /= undefined andalso Password /= undefined of
	true ->
	    case Username == "admin" andalso Password == m_config:get(admin_password, Context) of 
		true -> {ok, 1};
                _ ->
                     case mod_ufldap:check_user_pass(Username, Password) of
                       ok -> 
			     {ok, UserId} = get_or_create_user(Username, Context),
                             LoginCount = m_rsc:p(UserId, login_count, 0, Context), 
			     m_rsc:update(UserId, [{login_count, LoginCount + 1}, {last_login, calendar:local_time()}], z_acl:sudo(Context)),
			     {ok, UserId};
                       E -> E
		     end
	 	end;
	false ->
                undefined
    end.

get_or_create_user(Username, Context) ->
    case m_identity:lookup_by_username(Username,Context) of
        undefined -> add_user(Username, Context); %% return undefined of {ok, RscId}
        User -> UserId = proplists:get_value(rsc_id, User), 
		Groups = [{X} || X <- mod_ufldap:groups(Username)], %% Get groups list and proplist'ize it
                m_rsc:update(UserId, [{groups,Groups}], z_acl:sudo(Context)),
		{ok, UserId}
    end.

add_user(Username, Context) ->
    case mod_ufldap:search(Username) of
        {ok, LdapRec} ->
                    Cat = m_rsc:name_to_id_check("person", Context),
		    Props = [{category_id, Cat}, {is_published, true}
			     |get_user_props(LdapRec)],
		    {ok, UserId} = m_rsc:insert(Props, z_acl:sudo(Context)),
		    {ok, _IdentId} = m_identity:insert(UserId, "username_pw", Username, z_acl:sudo(Context)),
		    {ok, UserId};
	_Error -> _Error
    end.

get_user_props(LdapRec) ->
	[Name_First] = proplists:get_value("givenName", LdapRec, ["none"]),
	[Name_Surname] = proplists:get_value("sn", LdapRec, ["none"]),
	[Email] = proplists:get_value("mail", LdapRec, ["none"]),
	[UserName] = proplists:get_value("cn", LdapRec, ["none"]),
	[Title] = proplists:get_value("displayName", LdapRec, ["none"]),
	Groups = proplists:get_value("memberOf", LdapRec,[]),
	Props = [
		 {name_first, Name_First},
		 {name_surname, Name_Surname},
		 {email, Email},
		 {user_name, UserName},
		 {groups, Groups},
		 {title, Title}
		],
	Props.

