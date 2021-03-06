{extends file='_index.tpl'}

{block name="content-bar"}
    {if count($aTypes)>0}
        <div class="btn-group">
            <a href="{router page='admin'}contentadd/" class="btn btn-primary tip-top"
               title="{$aLang.action.admin.content_add}"><i class="icon-plus-sign"></i></a>
        </div>
    {/if}
{/block}

{block name="content-body"}
    <script>
        var fixHelper = function (e, ui) {
            ui.children().each(function () {
                $(this).width($(this).width());
            });
            return ui;
        };

        var sortSave = function (e, ui) {
            var notes = $('#sortable tbody.content tr');
            if (notes.length > 0) {
                var order = [];
                $.each(notes.get().reverse(), function (index, value) {
                    order.push({ 'id': $(value).attr('id'), 'order': index });
                });
                ls.ajax(aRouter['admin'] + 'ajaxchangeordertypes/', { 'order': order }, function (response) {
                    if (!response.bStateError) {
                        ls.msg.notice(response.sMsgTitle, response.sMsg);
                    } else {
                        ls.msg.error(response.sMsgTitle, response.sMsg);
                    }
                });
            }
        };

        $(function () {
            $("#sortable tbody.content").sortable({
                helper: fixHelper
            });
            $("#sortable tbody.content").disableSelection();

            $("#sortable tbody.content").sortable({
                stop: sortSave
            });
        });
    </script>
    {if count($aTypes)>0}
        <div class="b-wbox">
            <div class="b-wbox-content nopadding">

                <table class="table table-striped table-condensed pages-list" id="sortable">
                    <thead>
                    <tr>
                        <th class="span4">{$aLang.action.admin.content_title}</th>
                        <th>{$aLang.action.admin.content_url}</th>
                        <th>{$aLang.action.admin.content_status}</th>
                        <th class="span2">{$aLang.action.admin.content_actions}</th>
                    </tr>
                    </thead>

                    <tbody class="content">
                    {foreach from=$aTypes item=oType}
                        <tr id="{$oType->getContentId()}" class="cursor-x">
                            <td class="center">
                                {$oType->getContentTitle()|escape:'html'}{if !$oType->getContentCandelete()} <em>
                                    [{$aLang.action.admin.content_standart}]</em>{/if}
                            </td>
                            <td class="center">
                                {$oType->getContentUrl()|escape:'html'}
                            </td>
                            <td class="center">
                                <span>{if $oType->getContentActive()}{$aLang.action.admin.content_on}{else}{$aLang.action.admin.content_off}{/if}</span>
                            </td>
                            <td class="center">
                                <a href="{router page='admin'}contentedit/{$oType->getContentId()}/">
                                    <i class="icon-edit tip-top" title="{$aLang.action.admin.content_edit}"></i></a>
                                <a href="{router page='admin'}content/?toggle={if $oType->getContentActive()}off{else}on{/if}&content_id={$oType->getContentId()}&security_ls_key={$ALTO_SECURITY_KEY}">
                                    {if $oType->getContentActive()}
                                        <i class="icon-ban-circle tip-top"
                                           title="{$aLang.action.admin.content_turn_off}"></i>
                                    {else}
                                        <i class="icon-ok-circle tip-top"
                                           title="{$aLang.action.admin.content_turn_on}"></i>
                                    {/if}
                                </a>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {/if}

{/block}