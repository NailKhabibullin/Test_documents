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
    $params['user_id'] = $auth['user_id'];

    list($documents, $params) = fn_get_documents($params);
    
    Tygh::$app['view']->assign([
        'documents'  => $documents,
        'search' => $params,
    ]);

    // fn_print_die($documents);

} elseif ($mode === 'document') {

fn_print_die("$mode === 'document'documents.php");

}
