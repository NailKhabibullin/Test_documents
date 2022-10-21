<?php
/***************************************************************************
 *                                                                          *
 *   © Simtech Development Ltd.                                             *
 *                                                                          *
 * This  is  commercial  software,  only  users  who have purchased a valid *
 * license  and  accept  to the terms of the  License Agreement can install *
 * and use this program.                                                    *
 ***************************************************************************/

defined('BOOTSTRAP') or die('Access denied');

if ($_REQUEST['dispatch'] == 'test_documents.documents') {

    $schema['documents_search_block'] = [
        'templates' => 'addons/test_documents/blocks/documents_search_block.tpl',
    ];
    
}

return $schema;
