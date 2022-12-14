<?php
/***************************************************************************
 *                                                                          *
 *   © Simtech Development Ltd.                                             *
 *                                                                          *
 * This  is  commercial  software,  only  users  who have purchased a valid *
 * license  and  accept  to the terms of the  License Agreement can install *
 * and use this program.                                                    *
 ***************************************************************************/

use Tygh\Registry;
use Tygh\Tygh;

defined('BOOTSTRAP') or die('Access denied');

$return_url = fn_url('test_documents.documents');

if ($mode === 'documents') {

    $params = $_REQUEST ?? [];
    $params['items_per_page'] = $_REQUEST['items_per_page'] ?? Registry::get('settings.Appearance.admin_elements_per_page');

    if($auth['user_type'] === 'C') {
        $params['permission_groups'] = 'customer';
    } else {
        return [CONTROLLER_STATUS_NO_CONTENT];
    }

    list($documents, $params) = fn_get_documents($params);
    
    Tygh::$app['view']->assign([
        'documents'  => $documents,
        'search' => $params,
    ]);

} elseif ($mode === 'document') {

    $document = fn_get_document_data($_REQUEST['doc_id'], DESCR_SL);

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
    ));

    if (!empty($document['file_links'])) {
        $document['file_links'] = (!is_array($document['file_links'])) ? explode(',', $document['file_links']): $document['file_links'];
        $document['file_name'] = (!is_array($document['file_links'])) ? explode(',', $document['file_links']): $document['file_links'];
    }

    $download_links = $document['file_links'];

    Tygh::$app['view']->assign('document', $document);
    Tygh::$app['view']->assign('download_links', $download_links);
}
