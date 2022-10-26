{if $document}
    {assign var="id" value=$document.doc_id}
{/if}


{** documents section **}

{$allow_save = $document|fn_allow_save_object:"documents"}
{$hide_inputs = ""|fn_check_form_permissions}
{assign var="b_type" value=$document.type|default:"I"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" class="form-horizontal form-edit{if !$allow_save || $hide_inputs} cm-hide-inputs{/if}" name="documents_form" enctype="multipart/form-data">
<input type="hidden" class="cm-no-hide-input" name="user_id" value="{$document.user_id}" />
<input type="hidden" class="cm-no-hide-input" name="doc_id" value="{$id}" />

{capture name="tabsbox"}

    <div id="content_general">
        {hook name="documents:general_content"}
        <div class="control-group">
            <label for="elm_document_name" class="control-label cm-required">{__("name")}</label>
            <div class="controls">
            <input type="text" name="document_data[name]" id="elm_document_name" value="{$document.name}" size="25" class="input-large" /></div>
        </div>

        {if "ULTIMATE"|fn_allowed_for}
            {include file="views/companies/components/company_field.tpl"
                name="document_data[company_id]"
                id="document_data_company_id"
                selected=$document.company_id
            }
        {/if}

        <div class="control-group">
            <label for="elm_document_name" class="control-label cm-required">{__("category")}</label>
            <div class="controls">
            <input type="text" name="document_data[category]" id="elm_document_category" value="{$document.category}" size="25" class="input-large" /></div>
        </div>

        <div class="control-group" id="document_description">
            <label class="control-label" for="elm_document_description">{__("description")}:</label>
            <div class="controls">
                <textarea id="elm_document_description" name="document_data[document_description]" cols="35" rows="8" class="cm-wysiwyg input-large">{$document.document_description}</textarea>
            </div>
        </div>

        <div class="control-group">
            <label for="elm_document_type" class="control-label cm-required">{__("type")}</label>
            <div class="controls">
            <select name="document_data[type]" id="elm_document_type" onchange="Tygh.$('#document_text').toggle(); Tygh.$('#document_url').toggle();">
                <option {if $document.type == "I"}selected="selected"{/if} value="I">{__("test_documents.internal")}</option>
                <option {if $document.type == "P"}selected="selected"{/if} value="P">{__("test_documents.public")}</option>
            </select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="elm_document_date_{$id}">{__("creation_date")}</label>
            <div class="controls">
            {include file="common/calendar.tpl" date_id="elm_document_date_`$id`" date_name="document_data[timestamp]" date_val=$document.timestamp|default:$smarty.const.TIME start_year=$settings.Company.company_start_year}
            </div>
        </div>


        <div class="control-group">
            <label class="control-label" for="elm_document_upload_files_{$id}">{__("test_documents.upload_files")}</label>
            <div class="controls">
                <input name="uploaded_files[]" 
                        multiple="true" 
                        type="file" 
                        data-file-toast-position="bottom-center"
                        data-file-btn-clear="a.js-file-upload-clear"
                        class="custom-file-input" 
                        id="inputGroupFile01" 
                        aria-describedby="inputGroupFileAddon01">
                <label class="custom-file-label" for="inputGroupFile01">{__("test_documents.choose_files")}</label>
            </div>    
        </div>

        {include file="common/select_status.tpl" input_name="document_data[status]" id="elm_document_status" obj_id=$id obj=$document hidden=true}
        {/hook}

        {component name="configurable_page.section" entity="produdocuments" tab="detailed" section="availability"}
            <hr>
            {include file="common/subheader.tpl" title=__("availability") target="#acc_availability"}

            <div id="acc_availability" class="collapse in">
                
                <div class="control-group">
                    <label class="control-label">{__("usergroups")}:</label>
                    <div class="controls">
                        {foreach $usergroups as $usergroup}
                            <label class="checkbox inline" for="elm_field_data_usergroup_id_{$usergroup.usergroup_id}">
                                <input type="checkbox" name="field_data[usergroup_ids][]" id="elm_field_data_usergroup_id_{$usergroup.usergroup_id}"{if $ug_ids && $usergroup.usergroup_id|in_array:$ug_ids || $smarty.request.dispatch == "profile_fields.add"}} checked="checked"{/if} value="{$usergroup.usergroup_id}"/>
                                {$usergroup.usergroup}
                            </label>
                        {/foreach}
                    </div>
                </div>

                {if !$item.date_from && !$item.date_to}
                    {$date_disabled = 'disabled="disabled"'}
                {else}
                    {$date_disabled = false}
                {/if}
                <div class="control-group">
                    <label class="control-label" for="elm_use_avail_period">{__("use_avail_period")}:</label>
                    <div class="controls">
                        <input type="checkbox" name="avail_period" class="use_avail_period" data-id="{$id}"{if !$date_disabled} checked="checked"{/if} value="Y"/>
                    </div>
                </div>

                <div class="control-group {$no_hide_inputs}">
                    <label class="control-label" for="elm_buy_together_avail_from_{$id}">{__("avail_from")}:</label>
                    <div class="controls">
                        <input type="hidden" name="item_data[date_from]" value="0" />
                        {include file="common/calendar.tpl" date_id="elm_buy_together_avail_from_`$id`" date_name="item_data[date_from]" date_val=$item.date_from|default:$smarty.const.TIME start_year=$settings.Company.company_start_year extra=$date_disabled}
                    </div>
                </div>

                <div class="control-group {$no_hide_inputs}">
                    <label class="control-label" for="elm_buy_together_avail_till_{$id}">{__("avail_till")}:</label>
                    <div class="controls">
                        <input type="hidden" name="item_data[date_to]" value="0" />
                        {include file="common/calendar.tpl" date_id="elm_buy_together_avail_till_`$id`" date_name="item_data[date_to]" date_val=$item.date_to|default:$smarty.const.TIME start_year=$settings.Company.company_start_year extra=$date_disabled}
                    </div>
                </div>

            </div>

        {/component} {* detailed :: availability *}

        <div class="control-group">
            <label class="control-label">{__("user")}</label>
            <div class="controls">
            {if !$document.user_id}
                <p class="description">{"{$auth.user_id|fn_get_user_name}"}</p>
            {else}
                <p class="description">{"{$document.user_id|fn_get_user_name}"}</p>
            {/if}
                <p class="muted description">{__("test_documents.user_added_document")}</p>
            </div>
        </div>


    {if !fn_is_empty($user_data)}
        <div class="profile-info__name">
            {$user_full_name = "`$user_data.firstname` `$user_data.lastname`"|trim}
            {if $user_full_name}
                {if $user_data.user_id}
                    <a href="{"profiles.update?user_id=`$user_data.user_id`"|fn_url}">{$user_full_name}</a>,
                {else if $user_full_name}
                    {$user_full_name},
                {/if}
            {/if}
        </div>
    {/if}
    



    <!--content_general--></div>
    {hook name="documents:tabs_content"}
    {/hook}

{/capture}
{include file="common/tabsbox.tpl" content=$smarty.capture.tabsbox active_tab=$smarty.request.selected_section track=true}

{capture name="buttons"}
    {if !$id}
        {include file="buttons/save_cancel.tpl" but_role="submit-link" but_target_form="documents_form" but_name="dispatch[test_documents.update]"}
    {else}
        {if "ULTIMATE"|fn_allowed_for && !$allow_save}
            {assign var="hide_first_button" value=true}
            {assign var="hide_second_button" value=true}
        {/if}
        {include file="buttons/save_cancel.tpl" but_name="dispatch[test_documents.update]" but_role="submit-link" but_target_form="documents_form" hide_first_button=$hide_first_button hide_second_button=$hide_second_button save=$id}
    {/if}
{/capture}

</form>

{/capture}

{include file="common/mainbox.tpl"
    title=($id) ? $document.name : __("test_documents.new_document")
    content=$smarty.capture.mainbox
    buttons=$smarty.capture.buttons
    select_languages=true}

{** document section **}
