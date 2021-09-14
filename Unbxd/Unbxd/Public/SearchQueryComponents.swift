//
//  SearchQueryComponents.swift
//  Unbxd
//
//  Created by tilak kumar on 21/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

public class SearchQuery: QueryAbstract {    
    public var searchKey: String?
    
    public init(key: String, rows: Int? = nil,  start: Int? = nil, format: ResponseFormat = .JSON, spellCheck: Bool = false, analytics: Bool = false, statsField: String? = nil, variant: Variant? = nil, fields:Array<String>? = nil, facet: Facet? = nil, filter: FilterAbstract? = nil, categoryFilter: CategoryFilterAbstract? = nil, multipleFilter: MultipleFilterAbstract? = nil, multipleFilterOR: MultipleFilterAbstractOR? = nil,multipleFilterAND: MultipleFilterAbstractAND? = nil, fieldsSortOrder: Array<FieldSortOrder>? = nil, personalization: Bool? = nil) {
        super.init()
        self.searchKey = key
        
        self.rowsCount = rows
        self.pageIndex = start
        self.responseFormat = format
        self.spellCheck = spellCheck
        self.analytics = analytics
        self.showStatsForField = statsField
        self.variant = variant
        self.fields = fields
        self.facet = facet
        self.filter = filter
        self.categoryFilter = categoryFilter
        self.multipleFilter = multipleFilter
        self.multipleFilterOR = multipleFilterOR
        self.multipleFilterAND = multipleFilterAND
        self.fieldsSortOrder = fieldsSortOrder
        self.personalization = personalization
    }
}

public struct Variant {
    var enabled = false
    var count: Int8?
    
    public init(has:Bool, count:Int8? = nil) {
        self.enabled = has
        if let vCount = count {
            self.count = vCount
        }
    }
}

// MARK: *****FilterAbstract*****

public class FilterAbstract {
    var type = ReferenceType.None
}

public class TextFilter: FilterAbstract {
    var field: String?
    var value: String?
}

public class IdFilter: TextFilter {
    public init(field: String, value: String) {
        super.init()
        self.type = .TypeId
        self.field = field
        self.value = value
    }
}

public class NameFilter: TextFilter {
    public init(field: String, value: String) {
        super.init()
        self.type = .TypeName
        self.field = field
        self.value = value
    }
}

// MARK: *****FilterRangeAbstract*****

public class FilterRangeAbstract: FilterAbstract {
    
    var field: String?
    var lowerRange: String?
    var upperRange: String?
    
    init(field:String, lower: String, upper: String) {
        super.init()
        self.field = field
        self.lowerRange = lower
        self.upperRange = upper
    }
}

public class IdFilterRange: FilterRangeAbstract {
    public override init(field:String, lower: String, upper: String) {
        super.init(field: field, lower: lower, upper: upper)
        self.type = .TypeId
    }
}

public class NameFilterRange: FilterRangeAbstract {
    public override init(field:String, lower: String, upper: String) {
        super.init(field: field, lower: lower, upper: upper)
        self.type = .TypeName
    }
}

// MARK: *****CategoryFilterAbstract*****

public class CategoryFilterAbstract {
    var type = ReferenceType.None
    var categories = Array<String>()
    
    init(type: ReferenceType) {
        self.type = type
    }
}

public class CategoryIdFilter: CategoryFilterAbstract {
    public init() {
        super.init(type: .TypeId)
    }
}

public class CategoryNameFilter: CategoryFilterAbstract {
    public init() {
        super.init(type: .TypeName)
    }
}

// MARK: *****MultipleFilterAbstract*****

public class MultipleFilterAbstract {
    var operatorType = FilterOperatorType.None
    var type = ReferenceType.None
    var filters = Array<FilterAbstract>()
    
    init(filters: Array<FilterAbstract>, operatorType: FilterOperatorType) {
        self.filters = filters
        self.operatorType = operatorType
    }
}

public class MultipleIdFilter: MultipleFilterAbstract {
    public override init(filters: Array<FilterAbstract>, operatorType: FilterOperatorType) {
        super.init(filters: filters, operatorType: operatorType)
        self.type = .TypeId
    }
}

public class MultipleNameFilter: MultipleFilterAbstract {
    public override init(filters: Array<FilterAbstract>, operatorType: FilterOperatorType) {
        super.init(filters: filters, operatorType: operatorType)
        self.type = .TypeName
    }
}


// MARK: *****MultipleFilterAbstract AND*****

public class MultipleFilterAbstractAND {
    var operatorType = FilterOperatorType.None
    var type = ReferenceType.None
    var filters = Array<FilterAbstract>()
    
    init(filters: Array<FilterAbstract>, operatorType: FilterOperatorType) {
        self.filters = filters
        self.operatorType = operatorType
    }
}

public class MultipleIdFilterAND: MultipleFilterAbstractAND {
    public override init(filters: Array<FilterAbstract>, operatorType: FilterOperatorType) {
        super.init(filters: filters, operatorType: operatorType)
        self.type = .TypeId
    }
}

public class MultipleNameFilterAND: MultipleFilterAbstractAND {
    public override init(filters: Array<FilterAbstract>, operatorType: FilterOperatorType) {
        super.init(filters: filters, operatorType: operatorType)
        self.type = .TypeName
    }
}


// MARK: *****MultipleFilterAbstract for OR *****


public class MultipleFilterAbstractOR {
    var type = ReferenceType.None
    var filters = Array<MultipleFilterAbstract>()
    
    init(filters: Array<MultipleFilterAbstract>) {
        self.filters = filters
    }
}

public class MultipleIdFilterOR: MultipleFilterAbstractOR {
    public override init(filters: Array<MultipleFilterAbstract>) {
        super.init(filters: filters)
        self.type = .TypeId
    }
}

public class MultipleNameFilterOR: MultipleFilterAbstractOR {
    public override init(filters: Array<MultipleFilterAbstract>) {
        super.init(filters: filters)
        self.type = .TypeName
    }
}

// MARK: *****FieldSortOrder*****

public struct FieldSortOrder {
    var field: String?
    var order = SortOrder.None
    
    public init(field: String, order: SortOrder) {
        self.field = field
        self.order = order
    }
}
