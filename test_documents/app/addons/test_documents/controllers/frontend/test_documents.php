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

$return_url = fn_url('test_documents.documents');

if ($mode === 'documents') {

    $params = $_REQUEST ?? [];
    $params['items_per_page'] = $_REQUEST['items_per_page'] ?? Registry::get('settings.Appearance.admin_elements_per_page');
    // $params['user_id'] = $auth['user_id'];
    // fn_print_die($auth);
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

    Tygh::$app['view']->assign('document', $document);

    $usergroups = fn_get_usergroups(['exclude_types' => ['A'],'status' => ['A'], 'type' => $usergroup_type], DESCR_SL);
    Tygh::$app['view']->assign(['usergroups' => $usergroups]);

}
