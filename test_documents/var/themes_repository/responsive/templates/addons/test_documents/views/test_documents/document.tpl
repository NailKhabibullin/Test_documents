<div class="ty-mainbox-body">
    <div id="product_features_{$document.doc_id}">
        <div class="ty-feature">
            <div class="ty-feature__description ty-wysiwyg-content">
                <bdi>
                    <a>{__("description")}</a>
                </bdi>
                {$document.document_description nofilter}
            </div>
        </div>
    </div>
</div>

<div class="ty-mainbox-body">
    <div class="row-fluid">
        <bdi>
            <a>{__("text.documents.author:  ")}{$document.user_id|fn_get_user_name}</a>
        </bdi>
    </div>
</div>

{if $download_links}
    <div class="table-wrapper table-responsive-wrapper">
        <table class="table table-responsive">
        <thead>
            <tr>
                <th width="65%">{__("filename")}</th>
            </tr>
        </thead>
        <tbody>
        {foreach $download_links as $download_link name="link"}
            <tr class="cm-longtap-target">
                <td><a href="{"$download_link"|fn_url}" title="{__("push_for_download")}">{"$download_link"|mb_substr:'9'}</a></td>
            </tr>
        {/foreach}
        </tbody>
        </table>
    </div>
{/if}

{capture name="mainbox_title"}{$document.name}{/capture}
