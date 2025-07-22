import React, { useState, useEffect } from 'react';
import { Responsive, WidthProvider } from 'react-grid-layout';
import { Plus, Settings, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { toast } from 'sonner';
import dashboardService from '../../services/dashboard.service';
import DashboardWidget from './DashboardWidget';
import WidgetConfigDialog from './WidgetConfigDialog';
import 'react-grid-layout/css/styles.css';
import 'react-resizable/css/styles.css';

const ResponsiveGridLayout = WidthProvider(Responsive);

export default function DashboardGrid({ dashboardId }) {
  const [widgets, setWidgets] = useState([]);
  const [layouts, setLayouts] = useState({});
  const [isLoading, setIsLoading] = useState(true);
  const [configDialogOpen, setConfigDialogOpen] = useState(false);
  const [selectedWidget, setSelectedWidget] = useState(null);

  useEffect(() => {
    loadDashboard();
  }, [dashboardId]);

  const loadDashboard = async () => {
    try {
      setIsLoading(true);
      const dashboard = await dashboardService.getDashboardById(dashboardId);
      setWidgets(dashboard.widgets);
      
      // Convert widgets to layout format
      const layoutItems = dashboard.widgets.map(widget => ({
        i: widget.id.toString(),
        x: widget.position_x,
        y: widget.position_y,
        w: widget.width,
        h: widget.height,
        minW: 2,
        minH: 2,
      }));
      
      setLayouts({ lg: layoutItems });
    } catch (error) {
      toast.error('Failed to load dashboard');
    } finally {
      setIsLoading(false);
    }
  };

  const handleLayoutChange = async (layout, layouts) => {
    setLayouts(layouts);
    
    // Update widget positions in backend
    try {
      const updates = layout.map(item => ({
        widgetId: parseInt(item.i),
        positionX: item.x,
        positionY: item.y,
        width: item.w,
        height: item.h,
      }));
      
      // Update each widget position
      for (const update of updates) {
        await dashboardService.updateWidget(dashboardId, update.widgetId, {
          positionX: update.positionX,
          positionY: update.positionY,
          width: update.width,
          height: update.height,
        });
      }
    } catch (error) {
      toast.error('Failed to save layout changes');
    }
  };

  const handleAddWidget = () => {
    setSelectedWidget(null);
    setConfigDialogOpen(true);
  };

  const handleEditWidget = (widget) => {
    setSelectedWidget(widget);
    setConfigDialogOpen(true);
  };

  const handleDeleteWidget = async (widgetId) => {
    try {
      await dashboardService.deleteWidget(dashboardId, widgetId);
      setWidgets(widgets.filter(w => w.id !== widgetId));
      toast.success('Widget removed');
    } catch (error) {
      toast.error('Failed to remove widget');
    }
  };

  const handleSaveWidget = async (widgetData) => {
    try {
      if (selectedWidget) {
        // Update existing widget
        const updated = await dashboardService.updateWidget(
          dashboardId,
          selectedWidget.id,
          widgetData
        );
        setWidgets(widgets.map(w => w.id === updated.id ? updated : w));
        toast.success('Widget updated');
      } else {
        // Add new widget
        const newWidget = await dashboardService.addWidget(dashboardId, {
          ...widgetData,
          positionX: 0,
          positionY: 0,
          width: 4,
          height: 4,
        });
        setWidgets([...widgets, newWidget]);
        toast.success('Widget added');
      }
      setConfigDialogOpen(false);
    } catch (error) {
      toast.error('Failed to save widget');
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className="dashboard-grid">
      <div className="mb-4 flex justify-between items-center">
        <h2 className="text-2xl font-bold">Dashboard</h2>
        <Button onClick={handleAddWidget}>
          <Plus className="mr-2 h-4 w-4" />
          Add Widget
        </Button>
      </div>

      <ResponsiveGridLayout
        className="layout"
        layouts={layouts}
        onLayoutChange={handleLayoutChange}
        breakpoints={{ lg: 1200, md: 996, sm: 768, xs: 480, xxs: 0 }}
        cols={{ lg: 12, md: 10, sm: 6, xs: 4, xxs: 2 }}
        rowHeight={60}
        isDraggable={true}
        isResizable={true}
        compactType="vertical"
        preventCollision={false}
      >
        {widgets.map(widget => (
          <div key={widget.id.toString()} className="dashboard-widget">
            <div className="widget-header">
              <h3 className="widget-title">{widget.widget_title}</h3>
              <div className="widget-actions">
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={() => handleEditWidget(widget)}
                >
                  <Settings className="h-4 w-4" />
                </Button>
                <Button
                  variant="ghost"
                  size="icon"
                  onClick={() => handleDeleteWidget(widget.id)}
                >
                  <X className="h-4 w-4" />
                </Button>
              </div>
            </div>
            <DashboardWidget widget={widget} />
          </div>
        ))}
      </ResponsiveGridLayout>

      <WidgetConfigDialog
        open={configDialogOpen}
        onClose={() => setConfigDialogOpen(false)}
        onSave={handleSaveWidget}
        widget={selectedWidget}
      />

      <style jsx>{`
        .dashboard-grid {
          background: #f5f5f5;
          padding: 20px;
          border-radius: 8px;
        }
        
        .dashboard-widget {
          background: white;
          border-radius: 8px;
          box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
          padding: 16px;
          height: 100%;
          display: flex;
          flex-direction: column;
        }
        
        .widget-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 12px;
        }
        
        .widget-title {
          font-size: 16px;
          font-weight: 600;
          color: #333;
        }
        
        .widget-actions {
          display: flex;
          gap: 4px;
        }
        
        .react-grid-item.react-grid-placeholder {
          background: #d69e2e;
          opacity: 0.2;
          transition-duration: 100ms;
          z-index: 2;
          border-radius: 8px;
        }
        
        .react-grid-item > .react-resizable-handle {
          position: absolute;
          width: 20px;
          height: 20px;
          bottom: 0;
          right: 0;
          cursor: se-resize;
        }
        
        .react-grid-item > .react-resizable-handle::after {
          content: "";
          position: absolute;
          right: 3px;
          bottom: 3px;
          width: 5px;
          height: 5px;
          border-right: 2px solid #999;
          border-bottom: 2px solid #999;
        }
      `}</style>
    </div>
  );
}