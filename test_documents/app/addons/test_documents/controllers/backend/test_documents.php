<?php
/***************************************************************************
 *                                                                          *
 *   © Simtech Development Ltd.                                             *
 *                                                                          *
 * This  is  commercial  software,  only  users  who have purchased a valid *
 * license  and  accept  to the terms of the  License Agreement can install *
 * and use this program.                                                    *
 ***************************************************************************/

use Tygh\Api;
use Tygh\Enum\NotificationSeverity;
use Tygh\Enum\ObjectStatuses;
use Tygh\Enum\SiteArea;
use Tygh\Enum\UserTypes;
use Tygh\Enum\YesNo;
use Tygh\Registry;
use Tygh\Tools\Url;
use Tygh\Tygh;

defined('BOOTSTRAP') or die('Access denied');

$return_url = fn_url('test_documents.manage');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($mode === 'add' || $mode === 'update') {

        if (empty($_REQUEST['user_id'])) {
            $_REQUEST['user_id'] = $auth['user_id'];
        }

        $accessed_usergroups = $_REQUEST['field_data'];

        $document_data = $_REQUEST['document_data'];

        if (isset($document_data['timestamp'])) {
            $document_data['timestamp'] = fn_parse_date($document_data['timestamp']);
        }
        $document_data['doc_id'] = $_REQUEST['doc_id'];
        $document_data['user_id'] = $_REQUEST['user_id'];
        $document_data['item_data'] = $_REQUEST['item_data'];
        $document_data['permission_groups'] = implode(', ', $accessed_usergroups['usergroup_ids']);

        if (!empty($document_data)) {
            fn_update_document_data($document_data);
        }

        // fn_print_die($_REQUEST, $document_data);
        return [CONTROLLER_STATUS_OK, $return_url];
        
    } elseif ($mode === 'delete') {
        
        $doc_id = $_REQUEST['doc_id'];
        fn_delete_document($doc_id);
        
        return [CONTROLLER_STATUS_OK, $return_url];
    }

    return [CONTROLLER_STATUS_OK, $return_url];
}


/***********************
* REQUEST METHOD = GET *
************************/

if ($mode === 'update' || $mode === 'add') {

    $document = fn_get_document_data($_REQUEST['doc_id'], DESCR_SL);
   
    // if (empty($document)) {
    //     return array(CONTROLLER_STATUS_NO_PAGE);
    // }

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
    ));

    Tygh::$app['view']->assign('document', $document);

    $usergroups = fn_get_usergroups(['exclude_types' => ['A'],'status' => ['A'], 'type' => $usergroup_type], DESCR_SL);
    Tygh::$app['view']->assign(['usergroups' => $usergroups]);

    // fn_print_die($document);

} elseif ($mode === 'manage') {

    $params = $_REQUEST ?? [];
    $params['items_per_page'] = $_REQUEST['items_per_page'] ?? Registry::get('settings.Appearance.admin_elements_per_page');
    $params['user_id'] = $auth['user_id'];

    list($documents, $params) = fn_get_documents($params);
    
    Tygh::$app['view']->assign([
        'documents'  => $documents,
        'search' => $params,
    ]);

    // fn_print_die($documents, $params, $_REQUEST);
}
