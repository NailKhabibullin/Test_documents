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
                                <th><a class="cm-ajax" href="{"`$c_url`&sort_by=category&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("category")}{if $search.sort_by === "category"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $documents as $document name="documents"}
                                <tr class="cm-longtap-target">
                                    <td>{($smarty.foreach.documents.index + 1)}</td>
                                    <td>{$document.timestamp|date_format:"`$settings.Appearance.date_format`"}</td>
                                    <td>{$document.name|default:__("na")}</td>
                                    <td>{$document.category|default:__("na")}</td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            {else}
                <p class="no-items">{__("no_data")}</p>
            {/if}

            {include "common/pagination.tpl" div_id="pagination_contents_invitations"}

        </form>
    </div>

    {/capture}
    {include "common/tabsbox.tpl"
        content=$smarty.capture.tabsbox
        group_name=$runtime.controller
        active_tab=$smarty.request.selected_section
        track=true
    }
{/capture}
