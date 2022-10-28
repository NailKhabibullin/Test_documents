{include "common/pagination.tpl"}

<table class="ty-table ty-documents">
{if $documents}
    <thead>
        <tr>
            <th width="3%">
                <a class="{$ajax_class}" href="{"`$c_url`&sort_by=timestamp&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">
                    {__("date")}:
                </a>
                {if $search.sort_by == "timestamp"}{$sort_sign nofilter}{/if}
            </th>
            <th width="3%">
                <a class="{$ajax_class}" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">
                    {__("name")}:
                </a>{if $search.sort_by == "name"}{$sort_sign nofilter}{/if}
            </th>
            <th width="3%">
                <a class="{$ajax_class}" href="{"`$c_url`&sort_by=category&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id="pagination_contents">
                    {__("category")}:
                </a>
                {if $search.sort_by == "category"}{$sort_sign nofilter}{/if}
            </th>
        </tr>
    </thead>
        {foreach $documents as $document name="documents"}
            <tr class="cm-longtap-target">
                <td><a href="{"test_documents.document?doc_id={$document.doc_id}"|fn_url}" title="{$document.timestamp|date_format:"`$settings.Appearance.date_format`"}">{$document.timestamp|date_format:"`$settings.Appearance.date_format`"}</a></td>
                <td><a href="{"test_documents.document?doc_id={$document.doc_id}"|fn_url}" title="{$document.document_description}">{$document.name}</a></td>
                <td><a href="{"test_documents.document?doc_id={$document.doc_id}"|fn_url}" title="{$document.category}">{$document.category}</a></td>
            </tr>
        {/foreach}
</table>

{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include "common/pagination.tpl"}
{capture name="mainbox_title"}{__("test_documents.documents")}{/capture}
