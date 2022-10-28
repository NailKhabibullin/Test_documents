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

$return_url = fn_url('test_documents.manage');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($mode === 'add' || $mode === 'update') {
        if (empty($_REQUEST['user_id'])) {
            $_REQUEST['user_id'] = $auth['user_id'];
        }
        $document_data = $_REQUEST['document_data'];
        if (!empty($document_data['timestamp'])) {
            $document_data['timestamp'] = fn_parse_date($document_data['timestamp']);
        }
        if (!empty ($_REQUEST['item_data']['date_from'])) {
            $document_data['time_from'] = fn_parse_date($_REQUEST['item_data']['date_from']);
        }
        if (!empty ($_REQUEST['item_data']['date_from'])) {
            $document_data['time_to'] = fn_parse_date($_REQUEST['item_data']['date_from']);
        }
        $document_data['doc_id'] = $_REQUEST['doc_id'];
        $document_data['user_id'] = $_REQUEST['user_id'];

        $accessed_usergroups = $_REQUEST['field_data']['usergroup_ids'];
        foreach ($accessed_usergroups as &$usergroup_name) {
            $usergroup_name = fn_get_usergroup_name($usergroup_name);
        }

        $accessed_usergroups = implode(', ', $accessed_usergroups);
        $document_data['permission_groups'] = $accessed_usergroups;

        $uploads_dir = $_SERVER['DOCUMENT_ROOT'] . '/uploads';
        if (!file_exists($uploads_dir)) { 
                mkdir($uploads_dir);
            }
        foreach ($_FILES['uploaded_files']['error'] as $key => $error) {
            if ($error == UPLOAD_ERR_OK) {
                $tmp_name = $_FILES['uploaded_files']['tmp_name'][$key];
                $files_name = $_FILES['uploaded_files']['name'][$key];
                move_uploaded_file($tmp_name, "$uploads_dir/$files_name");
            }
        }

        $files_name = $_FILES['uploaded_files']['name'];
        foreach ($files_name as &$link) {
            $link = '/uploads/' . $link;
        }
   
        $files_name = implode(',', $files_name);
        $document_data['file_links'] = $files_name;

        if (!empty($document_data)) {
            fn_update_document_data($document_data);
        }

        return [CONTROLLER_STATUS_OK, $return_url];
        
    } elseif ($mode === 'delete') {
        
        $doc_id = $_REQUEST['doc_id'];
        fn_delete_document($doc_id);
        
        return [CONTROLLER_STATUS_OK, $return_url];
    }

    return [CONTROLLER_STATUS_OK, $return_url];
}

if ($mode === 'update' || $mode === 'add') {

    $document = fn_get_document_data($_REQUEST['doc_id'], DESCR_SL);

    Registry::set('navigation.tabs', array (
        'general' => array (
            'title' => __('general'),
            'js' => true
        ),
    ));

    Tygh::$app['view']->assign('document', $document);

    $usergroups = fn_get_usergroups(['exclude_types' => ['A'],'status' => ['A'], 'type' => $usergroup_type], DESCR_SL);
    Tygh::$app['view']->assign(['usergroups' => $usergroups]);

} elseif ($mode === 'manage') {

    $params = $_REQUEST ?? [];
    $params['items_per_page'] = $_REQUEST['items_per_page'] ?? Registry::get('settings.Appearance.admin_elements_per_page');
    if ($auth['user_type'] == 'V') {
        $params['user_id'] = $auth['user_id'];
    }

    list($documents, $params) = fn_get_documents($params);
    
    Tygh::$app['view']->assign([
        'documents'  => $documents,
        'search' => $params,
    ]);

    $usergroups = fn_get_usergroups(array('exclude_types' => $exclude_types), DESCR_SL);

    Tygh::$app['view']->assign(array(
        'usergroups'         => $usergroups,
        'usergroup_types'    => $usergroup_types,
    ));
}
