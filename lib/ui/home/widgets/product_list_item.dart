import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:overclock/core/models/product_list.dart';

class ProductListItem extends StatelessWidget {
  final ProductList product;
  final VoidCallback onClick;

  const ProductListItem({
    super.key,
    required this.product,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final previewProducts = product.products.take(3).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: FrostedCard(
        onClick: onClick,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(
                        alpha: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.list_alt_rounded,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      product.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: previewProducts
                    .map(
                      (p) => FrostedChip(
                        avatar: _productLeading(p.isDone, colorScheme),
                        label: Text(p.name),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 12),

              Text(
                'Voir plus',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productLeading(bool isDone, ColorScheme colorScheme) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDone ? Colors.green : colorScheme.onSurfaceVariant,
      ),
    );
  }
}
