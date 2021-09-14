//
//  QueryAbstract.swift
//  UnbxdClient
//
//  Created by tilak kumar on 17/03/18.
//  Copyright © 2018 Unbxd Limited. All rights reserved.
//
public class QueryAbstract {
    public var responseFormat = ResponseFormat.JSON
    public var pageIndex: Int?
    public var rowsCount: Int?
    public var variant: Variant?
    public var spellCheck = false
    public var analytics = false
    public var showStatsForField: String?
    public var version = "V2"
    public var personalization: Bool?
    public var facet: Facet?
    public var fields: Array<String>?
    public var filter: FilterAbstract?
    public var categoryFilter: CategoryFilterAbstract?
    public var multipleFilter: MultipleFilterAbstract?
    public var multipleFilterAND: MultipleFilterAbstractAND?
    public var multipleFilterOR: MultipleFilterAbstractOR?
    public var fieldsSortOrder: Array<FieldSortOrder>?
}
