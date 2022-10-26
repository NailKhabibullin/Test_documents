<div class="sidebar-row">
    <h6>{__("search")}</h6>
    <form name="documents_search_form" action="{"commission_documents.manage"|fn_url}" method="get">
        {if $smarty.request.redirect_url}
            <input type="hidden" name="redirect_url" value="{$smarty.request.redirect_url}" />
        {/if}

        <div class="sidebar-field">
            <label for="elm_name">{__("name")}</label>
            <div class="break">
                <input type="text" name="name" id="elm_name" value="{$search.name}" />
            </div>
        </div>

        <div class="sidebar-field">
            <label for="elm_document_description">{__("description")}</label>
            <div class="break">
                <input type="text" name="document_description" id="elm_document_description" value="{$search.document_description}" />
            </div>
        </div>
        
        <div class="sidebar-field">
            <label for="elm_category">{__("category")}</label>
            <div class="break">
                <input type="text" name="category" id="elm_category" value="{$search.category}" />
            </div>
        </div>

        <div class="sidebar-field">
            <label for="elm_type">{__("type")}</label>
            <div class="controls">
                <select name="type" id="elm_type">
                    {hook name="documents:search_form_document_type"}
                    <option value="">{__("all")}</option>
                    <option {if $search.type == "I"}selected="selected"{/if} value="I">{__("internal")}</option>
                    <option {if $search.type == "P"}selected="selected"{/if} value="P">{__("public")}</option>
                    {/hook}
                </select>
            </div>
        </div>

        <div class="sidebar-field">
            <label for="elm_status">{__("status")}</label>
            {assign var="items_status" value=""|fn_get_default_statuses:true}
            <div class="controls">
                <select name="status" id="elm_status">
                    <option value="">{__("all")}</option>
                    {foreach from=$items_status key=key item=status}
                        <option value="{$key}" {if $search.status == $key}selected="selected"{/if}>{$status}</option>
                    {/foreach}
                </select>
            </div>
        </div>

        <div class="sidebar-field">
            <label for="elm_permission_groups">{__("permission_groups")}</label>
            <select name="permission_groups" id="elm_permission_groups">
                <option value=""></option>
                {foreach from=$usergroups item="usergroup"}
                    <option value="{$usergroup.usergroup}"{if $search.usergroup == $usergroup.usergroup}selected="selected"{/if}>{$usergroup.usergroup}</option>
                {/foreach}
            </select>
        </div>

        <div class="sidebar-field">
            <input type="hidden" name="report_id" value="{$report.report_id}">
            <input type="hidden" name="selected_section" value="">
            {include file="common/period_selector.tpl" period=$period display="form"}
        </div>

        <div class="sidebar-field">
            <div class="break">
                <span class="btn cm-submit" data-ca-dispatch="dispatch[test_documents.manage]" data-ca-target-form="documents_search_form">{__("search")}</span>
            </div>
        </div>
    </form>
    <form action="{""|fn_url}" method="post" name="report_form_{$report.report_id}">
</div>
