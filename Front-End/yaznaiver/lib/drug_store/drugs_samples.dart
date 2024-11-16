import 'drug_store_medicine.dart';

final List<Medicine> medicines = [
  Medicine(
    id: 1,
    brandName: 'Tylenol',
    genericName: 'Acetaminophen',
    activeIngredient: 'Acetaminophen',
    inactiveIngredients: [
      'Corn Starch',
      'Magnesium Stearate'
    ],
    indicationsAndUsage: 'Pain reliever and fever reducer.',
    warnings: 'Liver warning: This product contains acetaminophen. Severe liver damage may occur.',
    adverseReactions: [
      'Nausea',
      'Rash',
      'Headache'
    ],
    dosageAndAdministration: 'Take 1-2 tablets every 4-6 hours as needed.',
    manufacturerName: 'Johnson & Johnson',
    storageAndHandling: 'Store at 20-25°C (68-77°F)',
    productNdc: '50580-488-10',
    route: 'Oral',
    doNotUse: 'If allergic to acetaminophen',
    price: 4.99,
    description: 'Effective for relieving mild to moderate pain and reducing fever.',
    imageUrl: 'https://example.com/images/tylenol.png',
    buy: true,
  ),
  Medicine(
    id: 2,
    brandName: 'Tramadol',
    genericName: 'Tramadol Hydrochloride',
    activeIngredient: 'Tramadol',
    inactiveIngredients: [
      'Magnesium Stearate',
      'Cellulose',
      'Lactose'
    ],
    indicationsAndUsage: 'Used to relieve moderate to moderately severe pain.',
    warnings: 'May cause drowsiness or dizziness. Risk of addiction.',
    adverseReactions: [
      'Nausea',
      'Dizziness',
      'Constipation',
      'Headache'
    ],
    dosageAndAdministration: 'Take 1 tablet every 4-6 hours as needed for pain.',
    manufacturerName: 'Aurobindo Pharma',
    storageAndHandling: 'Store at room temperature, away from moisture and heat.',
    productNdc: '65597-332-60',
    route: 'Oral',
    doNotUse: 'If allergic to Tramadol or similar medications.',
    price: 12.99,
    description: 'Effective pain reliever for moderate pain, prescribed for severe pain in certain cases.',
    imageUrl: 'https://example.com/images/tramadol.png',
    buy: false,
  ),
  Medicine(
    id: 3,
    brandName: 'Aspirin',
    genericName: 'Acetylsalicylic Acid',
    activeIngredient: 'Aspirin',
    inactiveIngredients: [
      'Corn Starch',
      'Microcrystalline Cellulose'
    ],
    indicationsAndUsage: 'Pain reliever and anti-inflammatory.',
    warnings: 'Reye\'s syndrome: Children and teenagers should not use this drug for chickenpox or flu symptoms.',
    adverseReactions: [
      'Stomach ulcers',
      'Bleeding',
      'Allergic reactions'
    ],
    dosageAndAdministration: 'Take 1 tablet every 4-6 hours as needed.',
    manufacturerName: 'Bayer',
    storageAndHandling: 'Store at 15-30°C (59-86°F)',
    productNdc: '00223-0679-01',
    route: 'Oral',
    doNotUse: 'If allergic to aspirin or salicylates',
    price: 3.99,
    description: 'Reduces pain, inflammation, and fever effectively.',
    imageUrl: 'https://example.com/images/aspirin.png',
    buy: true,
  ),
  Medicine(
    id: 4,
    brandName: 'Benadryl',
    genericName: 'Diphenhydramine',
    activeIngredient: 'Diphenhydramine HCl',
    inactiveIngredients: [
      'Lactose',
      'Magnesium Stearate'
    ],
    indicationsAndUsage: 'Allergy relief.',
    warnings: 'May cause drowsiness, avoid alcohol.',
    adverseReactions: [
      'Drowsiness',
      'Dry mouth',
      'Dizziness'
    ],
    dosageAndAdministration: 'Take 1-2 tablets every 4-6 hours as needed.',
    manufacturerName: 'Johnson & Johnson',
    storageAndHandling: 'Store at room temperature',
    productNdc: '50580-402-00',
    route: 'Oral',
    doNotUse: 'If allergic to diphenhydramine',
    price: 6.99,
    description: 'Relieves allergy symptoms like runny nose and sneezing.',
    imageUrl: 'https://example.com/images/benadryl.png',
    buy: true,
  ),
  Medicine(
    id: 5,
    brandName: 'Zyrtec',
    genericName: 'Cetirizine',
    activeIngredient: 'Cetirizine HCl',
    inactiveIngredients: [
      'Microcrystalline Cellulose',
      'Lactose Monohydrate'
    ],
    indicationsAndUsage: 'Allergy relief.',
    warnings: 'Do not exceed recommended dose.',
    adverseReactions: [
      'Headache',
      'Drowsiness',
      'Dry mouth'
    ],
    dosageAndAdministration: 'Take 1 tablet daily.',
    manufacturerName: 'GlaxoSmithKline',
    storageAndHandling: 'Store at room temperature',
    productNdc: '50580-402-01',
    route: 'Oral',
    doNotUse: 'If allergic to cetirizine',
    price: 7.49,
    description: 'Effective for relieving seasonal allergy symptoms.',
    imageUrl: 'https://example.com/images/zyrtec.png',
    buy: true,
  ),
  Medicine(
    id: 6,
    brandName: 'Allegra',
    genericName: 'Fexofenadine',
    activeIngredient: 'Fexofenadine HCl',
    inactiveIngredients: [
      'Pregelatinized Starch',
      'Magnesium Stearate'
    ],
    indicationsAndUsage: 'Allergy relief.',
    warnings: 'Do not take with other antihistamines.',
    adverseReactions: [
      'Drowsiness',
      'Dry mouth',
      'Fatigue'
    ],
    dosageAndAdministration: 'Take 1 tablet daily.',
    manufacturerName: 'Sanofi',
    storageAndHandling: 'Store at room temperature',
    productNdc: '50580-402-02',
    route: 'Oral',
    doNotUse: 'If allergic to fexofenadine',
    price: 6.49,
    description: 'Non-drowsy formula for managing allergy symptoms.',
    imageUrl: 'https://example.com/images/allegra.png',
    buy: true,
  ),
  Medicine(
    id: 7,
    brandName: 'Claritin',
    genericName: 'Loratadine',
    activeIngredient: 'Loratadine',
    inactiveIngredients: [
      'Magnesium Stearate',
      'Mannitol'
    ],
    indicationsAndUsage: 'Allergy relief.',
    warnings: 'Do not use if allergic to loratadine.',
    adverseReactions: [
      'Headache',
      'Dry mouth',
      'Fatigue'
    ],
    dosageAndAdministration: 'Take 1 tablet daily.',
    manufacturerName: 'Bayer',
    storageAndHandling: 'Store at room temperature',
    productNdc: '50580-402-03',
    route: 'Oral',
    doNotUse: 'If allergic to loratadine',
    price: 7.99,
    description: 'Effective daily allergy relief without drowsiness.',
    imageUrl: 'https://example.com/images/claritin.png',
    buy: true,
  ),
  Medicine(
    id: 8,
    brandName: 'Motrin',
    genericName: 'Ibuprofen',
    activeIngredient: 'Ibuprofen',
    inactiveIngredients: [
      'Silicon Dioxide',
      'Hypromellose'
    ],
    indicationsAndUsage: 'Pain reliever and fever reducer.',
    warnings: 'Stomach bleeding warning: This product contains an NSAID.',
    adverseReactions: [
      'Nausea',
      'Stomach pain',
      'Dizziness'
    ],
    dosageAndAdministration: 'Take 1-2 tablets every 4-6 hours as needed.',
    manufacturerName: 'Pfizer',
    storageAndHandling: 'Store at 15-30°C (59-86°F)',
    productNdc: '00378-0035-02',
    route: 'Oral',
    doNotUse: 'If allergic to ibuprofen or other NSAIDs',
    price: 5.99,
    description: 'Provides quick relief for pain and inflammation.',
    imageUrl: 'https://example.com/images/motrin.png',
    buy: true,
  ),
  Medicine(
    id: 9,
    brandName: 'Aleve',
    genericName: 'Naproxen',
    activeIngredient: 'Naproxen Sodium',
    inactiveIngredients: [
      'Croscarmellose Sodium',
      'Hypromellose'
    ],
    indicationsAndUsage: 'Pain reliever and anti-inflammatory.',
    warnings: 'Stomach bleeding warning: This product contains an NSAID.',
    adverseReactions: [
      'Nausea',
      'Stomach pain',
      'Heartburn'
    ],
    dosageAndAdministration: 'Take 1 tablet every 8-12 hours as needed.',
    manufacturerName: 'Bayer',
    storageAndHandling: 'Store at 15-30°C (59-86°F)',
    productNdc: '00223-0680-01',
    route: 'Oral',
    doNotUse: 'If allergic to naproxen or other NSAIDs',
    price: 4.49,
    description: 'Long-lasting relief from pain and inflammation.',
    imageUrl: 'https://example.com/images/aleve.png',
    buy: true,
  )
];
