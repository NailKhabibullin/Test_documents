<?php

use Tygh\Enum\Addons\VendorCommunication\CommunicationTypes;
use Tygh\Registry;
use Tygh\Enum\YesNo;

$schema['central']['test_documents']['items']['test_documents'] = [
    'attrs' => [
        'class'=>'is-addon'
    ],
    'href' => 'test_documents.manage',
    'position' => 200
];

return $schema;