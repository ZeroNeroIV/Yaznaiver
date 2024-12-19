package models

type Medicines struct {
	ID                      int    `json:"id"`
	BrandName               string `json:"brand_name"`
	GenericName             string `json:"generic_name"`
	ActiveIngredient        string `json:"active_ingredient"`
	InactiveIngredient      string `json:"inactive_ingredient"`
	IndicationsAndUsage     string `json:"indications_and_usage"`
	Warnings                string `json:"warnings"`
	AdverseReactions        string `json:"adverse_reactions"`
	DosageAndAdministration string `json:"dosage_and_administration"`
	ManufacturerName        string `json:"manufacturer_name"`
	StorageAndHandling      string `json:"storage_and_handling"`
	ProductNDC              string `json:"product_ndc"`
	Route                   string `json:"route"`
	DoNotUse                string `json:"do_not_use"`
	IsValid                 bool   `json:"is_valid"`
}
