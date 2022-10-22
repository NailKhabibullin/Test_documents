{** test_documents section **}
{hook name="test_documents:manage_mainbox_params"}
    {$page_title = __("test_documents.documents_title_{$type|strtolower}")}
    {$select_languages = true}
{/hook}
{capture name="mainbox"}

    {capture name="tabsbox"}
    <div id="content_detailed">
        <form action="{""|fn_url}" method="post" name="test_documents" class="cm-hide-inputs" enctype="multipart/form-data">
            <input type="hidden" name="fake" value="1" />
            {include "common/pagination.tpl"
                save_current_page=true
                save_current_url=true
                div_id="pagination_contents_invitations"
            }
            {$c_url = $config.current_url|fn_query_remove:"sort_by":"sort_order"}
            {$rev = $smarty.request.content_id|default:"pagination_contents_invitations"}
            {$c_icon = "<i class=\"icon-`$search.sort_order_rev`\"></i>"}
            {$c_dummy = "<i class=\"icon-dummy\"></i>"}
            
            {if $documents}
                <div id="pagination_contents_invitations">
                <h4 class="subheader">{__("test_documents.documents")}</h4>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=timestamp&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("date")}{if $search.sort_by === "timestamp"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("name")}{if $search.sort_by === "name"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=document_description&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("description")}{if $search.sort_by === "document_description"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=category&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("category")}{if $search.sort_by === "category"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=type&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("type")}{if $search.sort_by === "type"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=permission_groups&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("permission_groups")}{if $search.sort_by === "permission_groups"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>

                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by === "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $documents as $document name="documents"}
                                <tr class="cm-longtap-target">
                                    <td>{($smarty.foreach.documents.index + 1)}</td>
                                    <td>{$document.timestamp|date_format:"`$settings.Appearance.date_format`"}</td>
                                    <td>{$document.name|default:__("na")}</td>
                                    <td>{$document.document_description|default:__("na")}</td>
                                    <td>{$document.category|default:__("na")}</td>
                                    <td>{$document.type|default:__("na")}</td>
                                    <td>{$document.permission_groups|default:__("na")}</td>
                                    <td>{$document.status|default:__("na")}</td>
                                    <td class="row-status">
                                        {capture name="tools_list"}
                                            <li>{btn type="list" text=__("edit") href="test_documents.update?doc_id=`$document.doc_id`"}</li>
                                            {if $auth.user_type == 'A'}
                                                <li>{btn
                                                    type="list"
                                                    text=__("delete")
                                                    class="cm-confirm"
                                                    href="test_documents.delete?doc_id=`$document.doc_id`{if $delete_redirect_url}&redirect_url={$delete_redirect_url}{/if}"
                                                    method="POST"
                                                }
                                                </li>
                                            {/if}
                                        {/capture}
                                        {dropdown content=$smarty.capture.tools_list}
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            {else}
                <p class="no-items">{__("no_data")}</p>
            {/if}

            {include "common/pagination.tpl" div_id="pagination_contents_invitations"}




            {capture name="adv_buttons"}
                {hook name="orders:manage_tools"}
                    {include file="common/tools.tpl" tool_href="test_documents.add" prefix="bottom" hide_tools="true" title=__("add_new_document") icon="icon-plus"}
                {/hook}
            {/capture}

        </form>
    </div>
    
    {hook name="invited_customers_and_vendors:tabs_content"}
    {/hook}
    {/capture}
    {include "common/tabsbox.tpl"
        content=$smarty.capture.tabsbox
        group_name=$runtime.controller
        active_tab=$smarty.request.selected_section
        track=true
    }
{/capture}

{capture name="sidebar"}
    {include "common/saved_search.tpl" dispatch="commission_invited_customers.manage"}
    {include "addons/test_documents/views/test_documents/components/documents_search_form.tpl"}
{/capture}

{include "common/mainbox.tpl"
    title=$page_title
    content=$smarty.capture.mainbox
    select_languages=$select_languages
    sidebar=$smarty.capture.sidebar
    adv_buttons=$smarty.capture.adv_buttons
}

{** //test_documents section **}
