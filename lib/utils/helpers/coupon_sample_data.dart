import '../../features/coupon/domain/model/coupon.dart';

final List<Coupon> $sampleCoupons = [
  Coupon(
    id: '1',
    code: 'SAVE20',
    discountPercentage: 20.0,
    expiryDate: DateTime(2025, 12, 31),
    isActive: true,
    brand: 'Shopify',
    description: 'Get 20% off on all items',
    logoPath: 'assets/images/shop.png',
  ),
  Coupon(
    id: '2',
    code: 'GEM50',
    discountPercentage: 50.0,
    expiryDate: DateTime(2024, 6, 30),
    isActive: true,
    brand: 'GemStore',
    description: '50% discount on gems and collectibles',
    logoPath: 'assets/images/gem.png',
  ),
  Coupon(
    id: '3',
    code: 'HEART10',
    discountPercentage: 10.0,
    expiryDate: DateTime(2025, 3, 15),
    isActive: false,
    brand: 'LoveShop',
    description: '10% off on Valentine’s Day items',
    logoPath: 'assets/images/heart.png',
  ),
  Coupon(
    id: '4',
    code: 'FRIEND25',
    discountPercentage: 25.0,
    expiryDate: DateTime(2025, 8, 20),
    isActive: true,
    brand: 'FriendMart',
    description: '25% discount for friends and family',
    logoPath: 'assets/images/friend.png',
  ),
  Coupon(
    id: '5',
    code: 'EVENT30',
    discountPercentage: 30.0,
    expiryDate: DateTime(2025, 11, 1),
    isActive: true,
    brand: 'EventCo',
    description: 'Save 30% on your next event tickets',
    logoPath: 'assets/images/event.png',
  ),
  Coupon(
    id: '6',
    code: 'COIN15',
    discountPercentage: 15.0,
    expiryDate: DateTime(2025, 10, 10),
    isActive: true,
    brand: 'CoinWorld',
    description: 'Earn 15% off on coin purchases',
    logoPath: 'assets/images/coin.png',
  ),
  Coupon(
    id: '7',
    code: 'STAR50',
    discountPercentage: 50.0,
    expiryDate: DateTime(2026, 1, 1),
    isActive: false,
    brand: 'StarShop',
    description: '50% off on star-related merchandise',
    logoPath: 'assets/images/star-bubble.png',
  ),
  Coupon(
    id: '8',
    code: 'TREASURE40',
    discountPercentage: 40.0,
    expiryDate: DateTime(2025, 9, 15),
    isActive: true,
    brand: 'TreasureHunt',
    description: '40% off on all treasure chests',
    logoPath: 'assets/images/treasure.png',
  ),
  Coupon(
    id: '9',
    code: 'LIKE5',
    discountPercentage: 5.0,
    expiryDate: DateTime(2024, 12, 31),
    isActive: true,
    brand: 'LikeMart',
    description: '5% off on liked items',
    logoPath: 'assets/images/like-bubble.png',
  ),
  Coupon(
    id: '10',
    code: 'HAHA25',
    discountPercentage: 25.0,
    expiryDate: DateTime(2025, 7, 4),
    isActive: true,
    brand: 'HahaStore',
    description: 'Laugh and save 25% on select items',
    logoPath: 'assets/images/haha-emoji.png',
  ),
];