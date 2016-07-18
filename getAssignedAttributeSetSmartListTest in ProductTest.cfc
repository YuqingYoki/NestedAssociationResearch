//Brand.cfc associated from Product.cfc works well, but the opposite does not work
/* This Happened in ProductTest.cfc when running the following function
//In Product.cfc
property name="brand" cfc="Brand" fieldtype="many-to-one" fkcolumn="brandID" hb_optionsNullRBKey="define.none" fetch="join";
//In Brand.cfc
property name="products" singularname="product" cfc="Product" type="array" fieldtype="one-to-many" fkcolumn="brandID" inverse="true";
*/
private any function createMockAttributeSet(required boolean activeFlag, required string attributeSetObject) {
	 	var attributeSetData = {
	 		attributeSetID = "",
	 		activeFlag = arguments.activeFlag,
	 		attributeSetObject = arguments.attributeSetObject
	 	};
	 	return createPersistedTestEntity('attributeSet', attributeSetData);
}
	 
public void function getAssignedAttributeSetSmartListTest() {
		var mockAttributeSet1 = createMockAttributeSet(1,"Product");
		var mockAttributeSet2 = createMockAttributeSet(0,"Product");
		var mockAttributeSet3 = createMockAttributeSet(1,"Sku");
		
		var productTypeData = {
			productTypeID = "",
			attributeSets = [
				{
					attributeSetID = mockAttributeSet1.getAttributeSetID()
				}
			]
		};
		var mockProductType = createPersistedTestEntity('ProductType', productTypeData);
		
//		var mockProduct = createMockProduct(mockProductType.getProductTypeID());
		
		var brandData = {
			brandID = ""
//			products = [{
//				productID = mockProduct.getProductID()
//			}
//			]
		};
		var mockBrand = createPersistedTestEntity('Brand', brandData);
		
		var productData = {
			productID = "",
			brand = {
				brandID = mockBrand.getBrandID()
			}
		};
		var mockProduct = createPersistedTEstEntity('Product', productData);
		
		var result = mockProduct.getAssignedAttributeSetSmartList().getRecords(refresh = true);
		request.debug(arrayLen(result));
		
	 }
