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

$schema['controllers']['test_documents'] = [
    'modes' => [
        'manage' => [
            'permissions' => ['GET' => true, 'POST' => true],
        ],
        'add' => [
            'permissions' => ['GET' => true, 'POST' => true],
        ],
        'update' => [
            'permissions' => ['GET' => true, 'POST' => true],
        ],
        'delete' => [
            'permissions' => ['GET' => true, 'POST' => true],
        ],
    ],
];

$schema['controllers']['test_documents'] = [
    'permissions' => ['GET' => true, 'POST' => true],
];

return $schema;
