<div class="ty-mainbox-body">
    <div id="product_features_{$document.doc_id}">
        <div class="ty-feature">
            <div class="ty-feature__description ty-wysiwyg-content">
                <bdi>
                    <a>{__("text.documents.description")}</a>
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



<div class="hidden" title="{__("exported_files")}" id="content_exported_files">
{if $export_files}
    <div class="table-wrapper table-responsive-wrapper">
        <table class="table table-responsive">
        <thead>
            <tr>
                <th width="65%">{__("filename")}</th>
                <th width="20%">{__("filesize")}</th>
                <th width="15%">&nbsp;</th>
            </tr>
        </thead>
        <tbody>
        {foreach from=$export_files item=file name="export_files"}
        {assign var="file_name" value=$file.name|escape:"url"}
        <tr>
            <td data-th="{__("filename")}">
                <a href="{"exim.get_file?filename=`$file_name`"|fn_url}">{$file.name}</a></td>
            <td data-th="{__("filesize")}">
                {$file.size|number_format}&nbsp;{__("bytes")}</td>
            <td class="right" data-th="&nbsp;">
                <div class="hidden-tools">
                    <a href="{"exim.get_file?filename=`$file_name`"|fn_url}" title="{__("download")}" class="cm-tooltip btn">{include_ext file="common/icon.tpl" class="icon-download"}</a>
                    <a class="cm-ajax cm-confirm cm-post btn cm-tooltip" title="{__("delete")}" href="{"exim.delete_file?filename=`$file_name`&redirect_url=`$c_url`"|fn_url}" data-ca-target-id="content_exported_files">{include_ext file="common/icon.tpl" class="icon-trash"}</a>
                </div>
            </td>
        </tr>
        {/foreach}
        </tbody>
        </table>
    </div>
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}
<!--content_exported_files--></div>





{capture name="mainbox_title"}{$document.name}{/capture}