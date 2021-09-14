//
//  BrowseQueryComponents.swift
//  Unbxd
//
//  Created by tilak kumar on 21/03/18.
//  Copyright © 2018 Unbxd Ltd. All rights reserved.
//

import Foundation

public class BrowseQuery: QueryAbstract {
    public var browseCategoryQuery: CategoryAbstract?
    public var pageType: PageType?
    public init(categoryQuery: CategoryAbstract, pageType: PageType? = nil, rows: Int? = nil,  start: Int? = nil, format: ResponseFormat = .JSON, spellCheck: Bool = false, analytics: Bool = false, statsField: String? = nil, variant: Variant? = nil, fields:Array<String>? = nil, facet: Facet? = nil, filter: FilterAbstract? = nil, categoryFilter: CategoryFilterAbstract? = nil, multipleFilter: MultipleFilterAbstract? = nil,  multipleFilterOR: MultipleFilterAbstractOR? = nil,multipleFilterAND: MultipleFilterAbstractAND? = nil, fieldsSortOrder: Array<FieldSortOrder>? = nil, personalization: Bool? = nil) {
        super.init()
        self.browseCategoryQuery = categoryQuery
        self.pageType = pageType
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

// MARK: *****CategoryAbstract*****

public class CategoryAbstract {
    var type = ReferenceType.None
    var categoryType = CategoryType.None
}

public class CategoryFieldsAbstract: CategoryAbstract {
    var field: String?
    var value: String?
    
    public override init() {
        super.init()
        self.categoryType = .Fields
    }
}

public class CategoryIdField: CategoryFieldsAbstract {
    public init(field: String, value: String) {
        super.init()
        self.type = .TypeId
        self.field = field
        self.value = value
    }
}

public class CategoryNameField: CategoryFieldsAbstract {
    public init(field: String, value: String) {
        super.init()
        self.type = .TypeName
        self.field = field
        self.value = value
    }
}

public class CategoryPathAbstract: CategoryAbstract {
    var path: String?
    
    override init() {
        super.init()
        self.categoryType = .Path
    }
}

class CategoryIdPath: CategoryPathAbstract {
    public init(path: String) {
        super.init()
        self.type = .TypeId
        self.path = path
    }
}

public class CategoryNamePath: CategoryPathAbstract {
    public init(path: String) {
        super.init()
        self.type = .TypeName
        self.path = path
    }
}
