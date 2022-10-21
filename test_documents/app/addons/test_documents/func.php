<?php

use Tygh\Enum\SiteArea;
use Tygh\Enum\UserTypes;
use Tygh\Enum\YesNo;
use Tygh\Registry;
use Tygh\Tygh;
use Tygh\Addons\SdInvitedVendorsAndCustomers\InvitationMetaImage;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

function fn_get_documents($params = [], $items_per_page = 0) {

    $default_params = [
        'page' => 1,
        'items_per_page' => $items_per_page,
        'sort_by' => 'timestamp',
        'sort_order' => 'asc'
    ];

    $params = array_merge($default_params, $params);

    $condition = db_quote('WHERE 1 = 1');

    $limit = '';

    if (!empty($params['user_id'])) {
        $condition .= db_quote(' AND user_id = ?i', $params['user_id']);
    }

    if (!empty($params['name']) && fn_string_not_empty($params['name'])) {
        $params['name'] = trim($params['name']);
        $condition .= db_quote(' AND name LIKE ?l', '%' . $params['name'] . '%');
    }

    if (!empty($params['document_description']) && fn_string_not_empty($params['document_description'])) {
        $params['document_description'] = trim($params['document_description']);
        $condition .= db_quote(' AND document_description LIKE ?l', '%' . $params['document_description'] . '%');
    }

    if (!empty($params['category']) && fn_string_not_empty($params['category'])) {
        $params['category'] = trim($params['category']);
        $condition .= db_quote(' AND category LIKE ?l', '%' . $params['category'] . '%');
    }

    if (!empty($params['type'])) {
        $condition .= db_quote(' AND type = ?s', $params['type']);
    }

    if (!empty($params['permission_groups'])) {
        $condition .= db_quote(' AND permission_groups = ?i', $params['permission_groups']);
    }
    
    if (!empty($params['status'])) {
        $condition .= db_quote(' AND status = ?s', $params['status']);
    }


    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field('SELECT COUNT(doc_id) FROM ?:documents ?p', $condition);
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }

    $sortings = [
        'timestamp' => '?:documents.timestamp',
        'user_id' => '?:documents.user_id',
        'doc_id' => '?:documents.doc_id',
        'name' => '?:documents.name',
        'description' => '?:documents.document_description',
        'category' => '?:documents.category',
        'type' => '?:documents.type',
        'permission_groups' => '?:documents.permission_groups',
        'status' => '?:documents.status'
        ];
    
    $sorting = db_sort($params, $sortings, 'timestamp', 'asc');

    // fn_print_die($sorting);

    $documents = db_get_array('SELECT * FROM ?:documents ?p ?p', $condition, $sorting, $limit);

    // $qwery_to_database = db_quote('SELECT * FROM ?:documents ?p ?p', $condition, $sorting, $limit);
    // fn_print_die($documents);

    return [$documents, $params];
}

function fn_get_document_data($doc_id, $lang_code = CART_LANGUAGE) {

    $fields = $joins = array();
    $condition = '';

    $fields = array (
        '?:documents.doc_id',
        '?:documents.name',
        '?:documents.category',
        '?:documents.document_description',
        '?:documents.type',
        '?:documents.user_id',
        '?:documents.status',
        '?:documents.timestamp',
    );

    // if (fn_allowed_for('ULTIMATE')) {
    //     $fields[] = '?:banners.company_id as company_id';
    // }

    // $joins[] = db_quote("LEFT JOIN ?:banner_descriptions ON ?:banner_descriptions.banner_id = ?:banners.banner_id AND ?:banner_descriptions.lang_code = ?s", $lang_code);

    $condition = db_quote("WHERE ?:documents.doc_id = ?i", $doc_id);
    $condition .= (AREA == 'A') ? '' : " AND ?:documents.status IN ('A', 'H') ";

    $document = db_get_row("SELECT " . implode(", ", $fields) . " FROM ?:documents " . implode(" ", $joins) ." $condition");

    return $document;
}

function fn_delete_document($doc_id) {

    if (!empty($doc_id)) {
        db_query('DELETE FROM ?:documents WHERE doc_id = ?i', $doc_id);
    }

}

function fn_update_document_data($document_data) {

    if (!empty($document_data)) {
        $result = db_replace_into('documents', $document_data);
    }

    return $result;
    
}